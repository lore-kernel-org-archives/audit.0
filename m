Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD04E9C2B
	for <audit@vger.kernel.org>; Tue, 22 Sep 2026 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109542; cv=none; b=O+stIjXMogPgnjmaqXYrGdPaqs7lI+VmcLNhh6bu3CQmbLunMKWPVhqqiZRMnm1aVAqo3HH4p9S6gnJoDB2VzFHB2o+6zBO7ylHQh/7TF5yR1K4VnkVKxsNjVVqeZjqRrw4ZTy2eFfO1bUJeHGbTmjfFKZlVyU7oXk+QOnqQUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109542; c=relaxed/simple;
	bh=WyQU9QHk9Vz1mf2VJpYagBx20vwUZvluC6tqmcYWsPM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMyu4aCtfplwXYnKA5f8aEiI5HQm33F9MXXiDCfvsYxH2+nUzE/aMz0GJnlo+RdgLJ7ifrFIAl/sDw2ISkdS8r9LvGPZLPr0Zj9Kc9f+ngDvcQMLg0MEm7Pd2q6RnWTeUq79lYG/h65axULDlzDW2wRVy5nJYkVjcKth6xwOXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbgq7qrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbgq7qrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE491F0089B
	for <audit@vger.kernel.org>; Tue, 22 Sep 2026 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109534;
	bh=Kzyhfe8ISQzgOBwn4/hNdwzWRRlNdqiVheDG+SxdAu4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Rbgq7qrmBRfNglWCI7oEgYjxtlM4GbejwVMN7ZyDSOtCvcO6hg81gkX0oaZyJGejB
	 7ydEIta3vgQ1Qw8A6WMjcH/MUBU3aD2Cg8USXnP6gbLqOCiI519vEA6SWeb1Jp2iuC
	 VUh+7cQsU2INHNTn3/1Wp8wJOej5zaDyksswnhrldScg1RtboIYH+cpqEz3uhv2vLw
	 pOe7SFbDOdeAQlZWqll3Ty8jsgAEt1/aBi8UpIVEs/lUFPPS0OLoQDgPdvJXZgxjXZ
	 TZIvjejGX2fs0nq0OKV+mSsV0TCiewuwObG6tOdq/xgXvRMtrj97HyLEJdYbc/4Zj9
	 +VFPR9B+S0/zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] audit: fix exe mark UAF in kill_rules()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:38:54 +0000
Message-Id: <20260922203854.CAE491F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
> tree is pruned. It drops entry->rule.exe before removing the rule from
> the RCU-visible filter lists.
>=20
> After a rule has been installed with AUDIT_ADD_RULE, which requires
> CAP_AUDIT_CONTROL, removing the watched directory can race with another
> task that is still evaluating the rule. In that case, fsnotify can free
> the executable mark before the reader reaches audit_mark_compare(),
> causing a use-after-free.
>=20
> KASAN reports:
>=20
>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>=20
> Unlink the published rules from the RCU-visible lists and retain them
> on tree->rules for cleanup. If any rule has an executable mark, wait for
> a single RCU grace period before removing the marks and scheduling the
> entries for freeing. Otherwise, call_rcu() already provides the required
> deferred freeing without a synchronous wait.
>=20
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922202734.1344=
770-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

