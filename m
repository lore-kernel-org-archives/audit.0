Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520003B841C
	for <audit@vger.kernel.org>; Mon, 21 Sep 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021707; cv=none; b=QoiTWlpdftdogazgvpjg/s+fN+eXH1XgLKg9lyhB4tYmvWKGkUI8sL7aO3OxWvQSXHcYnu2XZytK6/Cc0gOmyAfOivtIKUZ3rQpuSCf5VPeWsQ7nuQOQKwMil2zbiCUNWsEVR+luhIdBjdT7K6QETTGpIKoNvWLvG+XfnJX5f6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021707; c=relaxed/simple;
	bh=36TLukI4+Usr4x1pL4gpUX17iKm1tizpN/cgG321VBQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ULBL+mqUdUr69Vn0ajdJAhIwga5wWjSP58C2FgoyVcbyeCpAiVKYHXLtGyzcf6jE+JXkQwVEuixSNAPkj7CoiyBlvnZ37ZIf4v4Q2t8jc70Q0U8W6gCiLI6bqZVSxTySUwMocXi/7dXZNwq1m0Ab/ZGnTWQMUTrCCvvvaIPCTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTmah4KW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTmah4KW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A121F1F000FF
	for <audit@vger.kernel.org>; Mon, 21 Sep 2026 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021705;
	bh=w/idy2huDlNlNK4G2+8SsKydbuNFw0iUCK8YbPujx9U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lTmah4KW8rr6VA6V5mJ9CFsdqonBWyB8ioRDafPTpbqsOnONHIwo4YbIzYtoyquYC
	 nMGk39AlPIFtuVsSVoO67pGewetwM62WKsBqWuo2FcCknkd0TGnSyf38TSOamUljEq
	 M5TFNGZnjeZvP3/MHAlPySNsyV6UcLMuZqab6c7JXx0Etljqh23ENuqu90fsavh8/Y
	 1RTDHXzldstbYt878HKFhGSQnVoPMokQOxHVVmoqoyupQGHSqKmx8jinZ2UneWH6jI
	 3OF6JiI3lMo53iuaknnBCR1bD6GK1EKrywltiOHllCO9eF7xvt9AWJTrL70/ZqeItZ
	 aXfZRmLPOBXPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:15:05 +0000
Message-Id: <20260921201505.A121F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] audit: O(N) synchronize_rcu() inside kill_rules() loop
--

commit b7d5542dc56408775e37d42010c82f61694ec4f9
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

audit: fix exe mark UAF in kill_rules()

This commit addresses a use-after-free when an audit tree is pruned by
reordering the removal of the executable mark after the rule is removed
from the rcu-visible list. It introduces a synchronize_rcu() call before
dropping the executable mark.

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 1ed19b7759129..864a58b6e2caf 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -553,11 +553,12 @@ static void kill_rules(struct audit_context *contex=
t, struct audit_tree *tree)
>  		if (rule->tree) {
>  			/* not a half-baked one */
>  			audit_tree_log_remove_rule(context, rule);
> -			if (entry->rule.exe)
> -				audit_remove_mark(entry->rule.exe);
>  			rule->tree =3D NULL;
>  			list_del_rcu(&entry->list);
>  			list_del(&entry->rule.list);
> +			synchronize_rcu();

[Severity: High]
Does this code introduce a regression by calling synchronize_rcu() inside
the list_for_each_entry_safe() loop in kill_rules()?

Executing synchronize_rcu() inside a list iteration loop causes sequential
grace period waits for every rule being removed. Each wait typically takes
10 to 30 milliseconds. If an audit tree has many rules, this loop could
block the executing thread for seconds or even minutes.

Since kill_rules() is called with the global audit_filter_mutex held (and
often audit_cmd_mutex via audit_ctl_lock()), this prolonged lock-holding
blocks any other process attempting to acquire audit mutexes.

Because unprivileged users can trigger the deletion of watched directories,
could this result in a local denial of service and hung task panics?

Would it be safer to batch this operation by removing all rules from the
rcu list into a local list first, executing a single synchronize_rcu()
outside the loop, and then iterating the local list to remove the marks
and schedule freeing?

> +			if (entry->rule.exe)
> +				audit_remove_mark(entry->rule.exe);
>  			call_rcu(&entry->rcu, audit_free_rule_rcu);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921195921.4174=
830-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
