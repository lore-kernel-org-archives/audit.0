Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0254409623;
	Tue, 22 Sep 2026 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109107; cv=none; b=mGxgr0ijdLBayfqQ30HQWbWAu6svbJz3wMZzqPfhb6FA/8dbW8TKuo+TWPRbyMBe3oxSyKloKkYB6N13Dc1cVjsnHwxNT+jB1onaYwlRKZbzXrLGu1Y4OJ6aZG0IIzcSk+Am5rG3QhhYEjM+2Q7+mb11z5DS6B8voLN0obQR/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109107; c=relaxed/simple;
	bh=B3w1xQI1tgkdSj/3amCZq3kMb4YuSj4xM2Cg0vxGQIc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ck3pj91EpzUw/b6tQP33AjiREOk6Cf5b6ZQ+TPONCitf3K0z31pxHn1C9kiulqClGBV9Q/8yI32ORqj6rTWqnUN8FIMlEgLCYAeHbhrooowWycEB8BFpU7xRhTjn5TrtL9Q9FFmyhbX/E6r36uHyS9JSB91ayUjWqQ9gP9NyKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=EDI5I5Sj; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=s7DW5ddW; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="EDI5I5Sj";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="s7DW5ddW"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790109090; bh=EIWXllr4KSUsiVr6oQY81Rp
	Mgz1OD3jzJb7BidL1jwQ=; b=EDI5I5SjlvPwKclhuFwo2Qig5cJbEmt+ZlpU2vEShrAAfYXjCk
	rGGwXoWayOKi+Jg4oyiuwtSVqzUt0HITTg+hTyMLQex1OC1f/7nR3SRsR9k8ICSkCNKY9X/KybT
	gaQmCnLlJlz/8KA8rAYY/OaUEGRtrFvtk1258RTCWET/cCkeoV3HFVk7utMSzA9v/APzXM2oAVf
	QMW5dpcmMGUf4mNl3cueTnUT+mpjtpBPw/f6xKwWjLFf3Vdb4sW9bLhG40OzDKiY0DgkKHsPQWv
	KhifFLW+RlXTRLHJMIfQd7drDjEem7ksP2NE/+TWN0YUfrYRrW2br4lMTTESy9P777Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790109090; bh=EIWXllr4KSUsiVr6oQY81Rp
	Mgz1OD3jzJb7BidL1jwQ=; b=s7DW5ddW6nHjqfUyBuqG/brQOmsZzMdlFS8LOVoHAPwnkdwVBi
	UrE8QiupNpkHhzv6poRJjdIo9W7Ccezt9oCw==;
Date: Tue, 22 Sep 2026 21:31:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
CC: rrobaina@redhat.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] audit: fix exe mark UAF in kill_rules()
In-Reply-To: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <3243770A-7E27-4142-9467-FC1FC98A72F1@mainlining.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 21:27:35 BST, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
>tree is pruned. It drops entry->rule.exe before removing the rule from
>the RCU-visible filter lists.
>
>After a rule has been installed with AUDIT_ADD_RULE, which requires
>CAP_AUDIT_CONTROL, removing the watched directory can race with another
>task that is still evaluating the rule. In that case, fsnotify can free
>the executable mark before the reader reaches audit_mark_compare(),
>causing a use-after-free.
>
>KASAN reports:
>
>    BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>
>Unlink the published rules from the RCU-visible lists and retain them
>on tree->rules for cleanup. If any rule has an executable mark, wait for
>a single RCU grace period before removing the marks and scheduling the
>entries for freeing. Otherwise, call_rcu() already provides the required
>deferred freeing without a synchronous wait.
>
>Fixes: 34d99af52ad4 ("audit: implement audit by executable")
>Assisted-by: Codex:gpt-5

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
>
>v2: Address Sashiko's review with Ricardo Robaina's improved patch:
>- Batch executable-mark teardown behind one synchronize_rcu() after
>  unlinking all rules, instead of waiting once per rule under the audit
>  mutexes.
>- Skip the synchronous wait when none of the removed rules has an
>  executable mark.
>
>v1: https://lore.kernel.org/all/20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr/
>
> kernel/audit_tree.c | 24 ++++++++++++++++++++----
> 1 file changed, 20 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>index 1ed19b775912..f2e81be8265e 100644
>--- a/kernel/audit_tree.c
>+++ b/kernel/audit_tree.c
>@@ -545,22 +545,38 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
> {
> 	struct audit_krule *rule, *next;
> 	struct audit_entry *entry;
>+	bool need_sync = false;
> 
> 	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
> 		entry = container_of(rule, struct audit_entry, rule);
> 
>-		list_del_init(&rule->rlist);
> 		if (rule->tree) {
> 			/* not a half-baked one */
> 			audit_tree_log_remove_rule(context, rule);
>-			if (entry->rule.exe)
>-				audit_remove_mark(entry->rule.exe);
> 			rule->tree = NULL;
> 			list_del_rcu(&entry->list);
> 			list_del(&entry->rule.list);
>-			call_rcu(&entry->rcu, audit_free_rule_rcu);
>+			if (entry->rule.exe)
>+				need_sync = true;
>+		} else {
>+			list_del_init(&rule->rlist);
> 		}
> 	}
>+
>+	if (list_empty(&tree->rules))
>+		return;
>+
>+	if (need_sync)
>+		synchronize_rcu();
>+
>+	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>+		entry = container_of(rule, struct audit_entry, rule);
>+
>+		list_del_init(&rule->rlist);
>+		if (entry->rule.exe)
>+			audit_remove_mark(entry->rule.exe);
>+		call_rcu(&entry->rcu, audit_free_rule_rcu);
>+	}
> }
> 
> /*

--- Thanks!
"I'm not a very positive person" - Linus torvalds
