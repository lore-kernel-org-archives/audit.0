Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FD41A918;
	Mon, 21 Sep 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020823; cv=none; b=ty9bWBzaiWoOnRAqCG+BuyoWG69/5OQ2TLfKtA1V9nR/AhkMiraphlIrynhfmwNpaKGMVIEad9/PcAWsWH+l6qFG0MOYLuKHI3cemNS+L5ns/zFHM7/cmmO84RdjSNMomxZFVkOO5mQuDA+7db9rgnpzXXL29naH655hOGwELNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020823; c=relaxed/simple;
	bh=CcU4GBwyYWo0Jw8qCVnLuLYztqeFikHwQvXY+iDLvfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D+3Y2obywWFH0anmcSXzt3QuS6sLTj2ygTXIG92QGyta/LCUMijd8IwtHUCZKh+6KbfHj6yKl83F8pq691C74xNuqN8jJWIBobsCgeEc1H7yTeuCsNdxEDygXpCCvtcBrHVSn9GFKwwk3HBbFfwtsfcO+dMfEvQ8Ef7iFRaUIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=ppwywcF0; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="ppwywcF0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=qPqAC8XIUQNSGAn1Xl0hkf8IfjOPmNZSVQTEu+4E3qc=; b=ppwywcF00VFv/6G5rc+Rg9RvSS
	C06QTg2vr704qKcNHlum4hn7hK/c3sbO7yaGVe7/72riaZXwIsCZ9p7NGyVh0j8E1W4TIc983PA1f
	4iR5aKEjP6iCGmS2mkon0LrfQ7isb49hvz2qQb2/PCd8bEF6Dk03VkLz32kPGQTxcxydP1wmjszgj
	CPfWAGDyFsFreX441GAN1u+elq5CLnwQo2TopsHxcasriet9QOlzGvkZRxkcT1QrXmVuB8Zou85b6
	H96f8W2Yo+iE2lqA+tnAKSKF8Wm9lBN+ZVTDUMXqhbhrSPK2aoSfyOhpzhGe5kZuXDmP3g4zQKv2a
	LR2g+qYg==;
Received: from [151.115.150.205] (port=53318 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x8kBW-00000002ZZA-1zWc;
	Mon, 21 Sep 2026 22:00:18 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] audit: fix exe mark UAF in kill_rules()
Date: Mon, 21 Sep 2026 19:59:22 +0000
Message-ID: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
CAP_AUDIT_CONTROL, removing or moving the watched directory can race
with another task that is still evaluating the rule. In that case,
fsnotify can free the executable mark before the reader reaches
audit_mark_compare(), causing a use-after-free.

KASAN reports:

    BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0

Remove the rule from the RCU-visible filter lists first, wait for a grace
period, and only then drop the executable mark. audit_del_rule() already
uses this ordering.

Fixes: 34d99af52ad4 ("audit: implement audit by executable")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/audit_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b7..864a58b 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -553,11 +553,12 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 		if (rule->tree) {
 			/* not a half-baked one */
 			audit_tree_log_remove_rule(context, rule);
-			if (entry->rule.exe)
-				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
 			list_del_rcu(&entry->list);
 			list_del(&entry->rule.list);
+			synchronize_rcu();
+			if (entry->rule.exe)
+				audit_remove_mark(entry->rule.exe);
 			call_rcu(&entry->rcu, audit_free_rule_rcu);
 		}
 	}
-- 
2.47.3

