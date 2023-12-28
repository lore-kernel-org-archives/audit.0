Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CA5B110E5;
	Thu, 28 Dec 2023 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C59576019CDE0;
	Thu, 28 Dec 2023 10:56:06 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: paul@paul-moore.com,
	eparis@redhat.com
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20auditfilter:=20Remove=20unnecessary?= =?UTF-8?q?=20=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Thu, 28 Dec 2023 10:56:00 +0800
Message-Id: <20231228025600.9796-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ret variable is assigned when it does not need to be defined, as it
has already been assigned before use.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/auditfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 8317a37dea0bb..be8c680121e46 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -788,7 +788,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
 {
-	int ret = 0;
+	int ret;
 	char *lsm_str;
 
 	/* our own copy of lsm_str */
-- 
2.18.2

