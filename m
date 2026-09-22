Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C03F5BC0;
	Tue, 22 Sep 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108955; cv=none; b=AUJ7eexOVQz7loBOQkW6sL1pVvaGzSA2dQiYHxWUuQz/4dvl9AYflrWOa9FHod0no1BpV8zhfrNllxptEKEmY6Z6ee/j7aMdZHcgQfIzkCYPOlXenyhuLaTScJdV1C+Le35Vs9t+7dGl0ie9lPvoyt1EDcM3yhHdtWDmWXOGIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108955; c=relaxed/simple;
	bh=OO/tGThV8FpOPUBfEbGDjQQx/xIpfvh9+2flmtnHsU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uSqE2AzLxeR5VflDbnJX4n//+OeG2d+QGoiRNFA8xqG8L8nhv94ScE/EiWE8kHdBom8FWQlYTB2mWbjINovFHxYse5HONBAQW6p7m+6eiCZOATRSHFezBPlqOFXVpfEOEfRsSaCoy08lTZhkWbExNilE775VG6QzXKYHAl+lKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=d0R0iIGh; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="d0R0iIGh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=yDG+FihD99g6EiGkCeXjNO3B7eVRuJlKpK6IMk1FsyI=; b=d0R0iIGhO99IWvXWtISK6Zds4C
	KXUHLOdVxAMvDPFcmyVN/jYtvHFa9AZVRIQQUjmDnd0FggJ7xWA14CKRocYEVC2ULPtD61L4d0cHo
	RnOriFgeWDpmRf90cR0gn2nIrNJwy4eebhKjJ8cGLXdNfjZN5UNv0xAVL1o/kwNeBs0AvPvIrKr2n
	rBYSYqpMMnumJ7hBtP0mWGGOCp4so9lF5uDzsWGt+FA83MWB7tplElNFoEwQyqRl6LMZ4TULVAse8
	AgTppPY46W5H5q8cqeYrBUiYbhq6ZtESuwM5QuI0jh/Z8EWMduDOZ9EhD0otntu6inF0Awn+oT11R
	35X9e50w==;
Received: from [151.115.150.205] (port=44866 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x976p-0000000BLWr-1poj;
	Tue, 22 Sep 2026 22:28:58 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: rrobaina@redhat.com,
	brads@mainlining.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2] audit: fix exe mark UAF in kill_rules()
Date: Tue, 22 Sep 2026 20:27:35 +0000
Message-ID: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
tree is pruned. It drops entry->rule.exe before removing the rule from
the RCU-visible filter lists.

After a rule has been installed with AUDIT_ADD_RULE, which requires
CAP_AUDIT_CONTROL, removing the watched directory can race with another
task that is still evaluating the rule. In that case, fsnotify can free
the executable mark before the reader reaches audit_mark_compare(),
causing a use-after-free.

KASAN reports:

    BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0

Unlink the published rules from the RCU-visible lists and retain them
on tree->rules for cleanup. If any rule has an executable mark, wait for
a single RCU grace period before removing the marks and scheduling the
entries for freeing. Otherwise, call_rcu() already provides the required
deferred freeing without a synchronous wait.

Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

v2: Address Sashiko's review with Ricardo Robaina's improved patch:
- Batch executable-mark teardown behind one synchronize_rcu() after
  unlinking all rules, instead of waiting once per rule under the audit
  mutexes.
- Skip the synchronous wait when none of the removed rules has an
  executable mark.

v1: https://lore.kernel.org/all/20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr/

 kernel/audit_tree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b775912..f2e81be8265e 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -545,22 +545,38 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
+	bool need_sync = false;
 
 	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
 		entry = container_of(rule, struct audit_entry, rule);
 
-		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
 			audit_tree_log_remove_rule(context, rule);
-			if (entry->rule.exe)
-				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
 			list_del_rcu(&entry->list);
 			list_del(&entry->rule.list);
-			call_rcu(&entry->rcu, audit_free_rule_rcu);
+			if (entry->rule.exe)
+				need_sync = true;
+		} else {
+			list_del_init(&rule->rlist);
 		}
 	}
+
+	if (list_empty(&tree->rules))
+		return;
+
+	if (need_sync)
+		synchronize_rcu();
+
+	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
+		entry = container_of(rule, struct audit_entry, rule);
+
+		list_del_init(&rule->rlist);
+		if (entry->rule.exe)
+			audit_remove_mark(entry->rule.exe);
+		call_rcu(&entry->rcu, audit_free_rule_rcu);
+	}
 }
 
 /*
