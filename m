Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B2239A806;
	Tue, 22 Sep 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059124; cv=none; b=EPHozu0wHjoYaJRqLut8jcXqflHQ5Z3zeUL9b5OHvsW6bl8DSFc/RZHLrJuBUJNo/C2bp125/h6IXlukmiyxMs/CyRYdi0xS4K9+oZ8zxywdo8nvmulXBlnKLS3fdI5+143DcOGxC85Z2ADlcv/7501M+ZeNTj+HbdatQcF9CV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059124; c=relaxed/simple;
	bh=He77vsHRNDY9rs0A96qofuF3MurifC9nbGeeTckiXUQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cYLnJpTUl/1ImVFY/NnDxV0Q/OwOWPjMOfX7QW14+cL/HiGrZXAnLrpIQT5Yy3rwKvA0brchkZCYX3V2oI4GgFq9U3Qq2ID43h3gMnJm3aFsAJOx/s20RoN2siP25Ni2g73heOZeCdYQNJF/lX3ocmc3ohM8tnLn4MDEo4TtCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qajzNPZz; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=iBDLAzi8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qajzNPZz";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="iBDLAzi8"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790059115; bh=rmhlXTCnktDQFqOr1RHbFH/
	/RfhFjubf8mGvONiAb98=; b=qajzNPZzOdbglT9mEiBQopT6Ti3o2zgF3pUD4whrq0bUMDed8+
	FlXgcXHPD2EJ3TUfkdrqSfcQGNlQfPtVnv6nhS4K+qX/uofzBflltygbRbFcgIaWI3essgJBSyG
	FP4uGP6hcr+87e9OtIGDjJsUsZeIKpLXbLrPhHbBGPgzyWhTgWUUBQMdavHH9Hiy7lTLNpunnGB
	3p6oZAZ/ahy7MJZ3JUDq1Gu0YTyNRoT7rRkWMF+gYaA3ijfARuiJcg7CGrXblSZAvlrBLvJDGWv
	BXKy6iNlA/zzahMs/OZvUze8Ji8lpaqOY3FjGfc3/Yc5Pk/WSEkrZQxK5AtdnXDljxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790059115; bh=rmhlXTCnktDQFqOr1RHbFH/
	/RfhFjubf8mGvONiAb98=; b=iBDLAzi8Wzel/qktLLMV76VlCb/+bkIo34QBKsl4OGpgzjlAeD
	ZK+gttBQl0UCUUdiu4l3z+7sBuNTulEJeQCw==;
Date: Tue, 22 Sep 2026 07:38:36 +0100
From: Bradley Morgan <brads@mainlining.org>
To: jeremy.jean@oss.cyber.gouv.fr
CC: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org,
 paul@paul-moore.com
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
In-Reply-To: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <31CAFD5E-4A68-4E19-B255-62C920A03378@mainlining.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 21 September 2026 20:59:22 BST, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
>tree is pruned. It drops entry->rule.exe before removing the rule from
>the RCU-visible filter lists.
>
>After a rule has been installed with AUDIT_ADD_RULE, which requires
>CAP_AUDIT_CONTROL, removing or moving the watched directory can race
>with another task that is still evaluating the rule. In that case,
>fsnotify can free the executable mark before the reader reaches
>audit_mark_compare(), causing a use-after-free.
>
>KASAN reports:
>
>    BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>
>Remove the rule from the RCU-visible filter lists first, wait for a grace
>period, and only then drop the executable mark. audit_del_rule() already
>uses this ordering.
>
>Fixes: 34d99af52ad4 ("audit: implement audit by executable")
>Assisted-by: Codex:gpt-5

NAK, read sashiko and generate a V2,  and then CC me.

>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
> kernel/audit_tree.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>index 1ed19b7..864a58b 100644
>--- a/kernel/audit_tree.c
>+++ b/kernel/audit_tree.c
>@@ -553,11 +553,12 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
> 		if (rule->tree) {
> 			/* not a half-baked one */
> 			audit_tree_log_remove_rule(context, rule);
>-			if (entry->rule.exe)
>-				audit_remove_mark(entry->rule.exe);
> 			rule->tree = NULL;
> 			list_del_rcu(&entry->list);
> 			list_del(&entry->rule.list);
>+			synchronize_rcu();
>+			if (entry->rule.exe)
>+				audit_remove_mark(entry->rule.exe);
> 			call_rcu(&entry->rcu, audit_free_rule_rcu);
> 		}
> 	}
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
