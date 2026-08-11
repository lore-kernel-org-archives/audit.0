Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E23B27CF;
	Tue, 11 Aug 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485714; cv=none; b=SlWifyNswOvC+bndrzWyD6HIX2SOAje0SaebjhyoPCPmMvyuclwVIb9SdIcbzuBMh0lBVR8lARCl76mtn16jZcpsGeq+WiJk2/5YM/5uTJVMNF1YjPPu3U9EQ4a428gK7ZJufN04Gzthds7zV2XLF3f88l9iEbxX23vLbGR5lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485714; c=relaxed/simple;
	bh=B0sp1A8eEY/DdBvcTmjkRqIbjuY1AAom3/xVVFWhUIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JbmtsjTdVs+hG1VygMj+rIahvzBJ28iBsYjlkE0wpTTglu6h6hlXMyh0jowCxCImdWUeuLkhgOoWb7PZ6ESpMhZn1qiX+GCa3jqApMDe0+no9iLQUoIko9N1+3EXVZJyK3f7Hr9AQeoFiUG7NO91R623ZbKuav7ez85K6gmXHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=BBPEcLLM; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="BBPEcLLM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9WSDOJhgBdbkl9FirK6VjGWEjStGMItBQCq9OixTMZk=; b=BBPEcLLMEE4e3BgqmFhVYPteW8
	sNZ5Zg+mCgAYavD0XnV5NXX8bCPyGANLhSZu9vfCbx3R2uLXWgn7X+6hMLgGAjNjfszl/GM+w/cO4
	dXTc4NhoZbQpOCzy9QVJiEqYBI1ZaD14E9VSBRW1pNV7PFSslbrUEhqzqm3Dd/VJFX8Bub+Zpl5oA
	hPJWDXlCXQcrVlz6873MPLp3lpL31MTFeCK5IQtZ31hQFTnPHGb/PSY+pYuvunK4M/tgj3KRj5D4a
	Zm3iemzvhRoBFOTIzcfrNBxwPBqcMBriDn+em1vfV8LD5y81GBBC2gks7KbntLH83vjUS9IQKfDxU
	0+PsPidg==;
Received: from [151.115.150.205] (port=41644 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wtuXZ-00000007r0W-0XEq;
	Wed, 12 Aug 2026 00:01:44 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: audit@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] audit: avoid dropping live tree ref on fsnotify rule autoremove
Date: Tue, 11 Aug 2026 22:01:27 +0000
Message-ID: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
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

audit_del_rule() is used for both netlink deletion templates and internal
fsnotify autoremove.  The former passes a parsed template which owns a
temporary tree reference; the latter passes the installed entry itself.

The unconditional audit_put_tree() at the end of audit_del_rule() assumes
the template case.  For mixed AUDIT_DIR plus AUDIT_EXE rules, an fsnotify
autoremove event therefore drops the installed rule's live tree reference.
Repeating this across rules sharing the same tree can free the tree while
another rule still references it, and a later autoremove dereferences the
freed pathname while comparing rules.

Move the temporary-tree put to audit_rule_change(), the caller that owns
deletion templates.  Keep it in the AUDIT_DEL_RULE cleanup so both
successful deletion and -ENOENT still release the parser-owned tree.

Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/auditfilter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 7f791afe5791..666c2091b9e4 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1023,7 +1023,6 @@ static inline int audit_add_rule(struct audit_entry *entry)
 int audit_del_rule(struct audit_entry *entry)
 {
 	struct audit_entry  *e;
-	struct audit_tree *tree = entry->rule.tree;
 	struct list_head *list;
 	int ret = 0;
 #ifdef CONFIG_AUDITSYSCALL
@@ -1071,9 +1070,6 @@ int audit_del_rule(struct audit_entry *entry)
 out:
 	mutex_unlock(&audit_filter_mutex);
 
-	if (tree)
-		audit_put_tree(tree);	/* that's the temporary one */
-
 	return ret;
 }
 
@@ -1158,6 +1154,8 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
 	}
 
 	if (err || type == AUDIT_DEL_RULE) {
+		if (type == AUDIT_DEL_RULE && entry->rule.tree)
+			audit_put_tree(entry->rule.tree); /* that's the template one */
 		if (entry->rule.exe)
 			audit_remove_mark(entry->rule.exe);
 		audit_free_rule(entry);
-- 
2.47.3

