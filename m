Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4663EC2CB
	for <audit@vger.kernel.org>; Tue, 30 Jun 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849169; cv=none; b=sJCaouOqqGyVRuTVbPL0gXPs/NgCLCOm98ctezaLqmDJTaiYqqO35WniS1wg1qF2+i03EdvyR1IwkJNOPyq4YZqzsh6bP5Fw1GGGs3QCZejl6uv9CwdHDU/y6CfIubiRxndRhgrvOP7gHQ15NgRGJCSRir0M/h7sTKqa5lfapNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849169; c=relaxed/simple;
	bh=z14pLorvyA1w/b+3+hTVdHjB4VHQ30Mpr3CtVy092hA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n/rBODc8636dx5lEIs791hLG3kqX1nxPK7nlFrIVVwsnjb0Dk8grL9DliMbPZA+Yu8uXVhyWHzFXtH26LNBJVpVAZpQGof/i9WRD1DWctZATj3QedhRG7WI9QFB4myzWQMoGnEFLUevoi4XBU3uGWcyNd5PfPi5P4/KkcGg/D5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K1O0MY0o; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K1O0MY0o"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519e7faecf1so71370131cf.0
        for <audit@vger.kernel.org>; Tue, 30 Jun 2026 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782849167; x=1783453967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=90CtHt/VPLR0O+E6qLgXcGZcCJuN51bQT/feTznSyX8=;
        b=K1O0MY0oe2C0T6qhbWl1gveVP+jBosPhMI/s1bsxaJ/kc2LXshuInanWLO5tIIL5gN
         g4n8pJwq0wnHeQe9aebnaVoHfI9jpfNGtzrCjFPHC3zpXT2LupdPCxiSGMlhHvnS76VR
         OJZkQZXHzm51OErePFNocl2ES3Nz3DX3CtcOgaog13honLdaVs4MotuF0oi+zipkfYdk
         m0v/BlvET+Y3LIYn7+E72YwNoqCKLF5hz1mCG7BUJhohuiUFQdHpzD29yzpaOw1BZMIh
         hpPMBPDbesUEJzidEdfTr/fzMt1wqokaESZ5vlLxrjzipc63wZrD5B5JSkzFyvNF2Tr1
         UCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849167; x=1783453967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90CtHt/VPLR0O+E6qLgXcGZcCJuN51bQT/feTznSyX8=;
        b=fq2NF2f3Kz4BLb1z+GmMrANcm8y4cgzmbrgmQbQC/LxsOB5QWnyu4mhB2A5tEPvy80
         sE1C3uR5/p2o2bEznkxMtns2RZDfNFcKhcGkJIwrUzc7DDWrpZbCxfqh4507BhgxNBCk
         ckScg+d3jPw3NbxCkRv9AA7Lt76nouNfIh5mCLeipozmD0KkNvWe61Ri78cifVqHKbg0
         lvvYjvSKBawsve0Qvf5V/LW2X134Vd1dWeevdSCqKLLiR6YxBrfeVUJA80g3clyXEU90
         dAq0sBSzdECSsSFh115BcSzTPbPw7azqfwVnqDRntA0HCSmXBTqaNDOPjPFLRj2MCFWa
         QE8w==
X-Gm-Message-State: AOJu0YxOo1bLGup6tWPqFqFRGoNzvxjAe5S6TEVBkYagE9xrBNfefQMI
	D2xTOmkcy14tBQ22RX9PWjgMmTkLhZRu/zmyAVEfkf9UPFZ/ocN9+TYiJ617K0caVjliZsqwEh9
	tD9Fr0A==
X-Gm-Gg: AfdE7cnBf7VCKdImG6isjw91nPha+jJJHoa4/Vlot3hArloNsuaTlVVH2hkYEqjPfpV
	GGKjq+yIN+nx2MwEP5c6FRmrCakddJG4HqmQzRLF7L0hyaOT5sg78OBq85vtEg++hlemPv704Xv
	ZrLdzCBFOsyyDOutoAZ8YXP+gfNLnrj2KLAQcZbbzIyxsDqLqZPNH60/H6rQtmUBERTms95/wbh
	pl1Eo6homtxTLFCExFzkRW2Y2+krJ3gpUa8NoMjHoDLpvzhQolhD+t6/mlme5CGLZz6z7TymlXw
	iLpP+s3jkClVxDTWpU7dERh8pYYHGofKEKnv2RPrLFrCnrp86ILIwVyLVZ3NHKtvFw68ZcJG0Tk
	v/hn1G88QVpyduZZxvXS+RXCn+Sxoz17Y4H+1jG3lvL0SeH5AOTLElA2z1x45L/Q80hUgJW1rlT
	bt95gg3aVkKZn17yycKKszdQxcodHA/7mZxPU2nT2qzG+mY51yEnbS70QT6A==
X-Received: by 2002:a05:622a:40cd:b0:51a:8eca:78e3 with SMTP id d75a77b69052e-51c1c958f0emr28211861cf.5.1782849166818;
        Tue, 30 Jun 2026 12:52:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a265efsm26050001cf.27.2026.06.30.12.52.46
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:52:46 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [RFC PATCH] audit: drop BUG_ON() from audit_log_XXX()
Date: Tue, 30 Jun 2026 15:52:43 -0400
Message-ID: <20260630195242.367870-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=paul@paul-moore.com; h=from:subject; bh=z14pLorvyA1w/b+3+hTVdHjB4VHQ30Mpr3CtVy092hA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqRB6KhnSS44UVbL7t6RpmLihdt85g1XtV2null TnyVDycYCOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCakQeigAKCRDqIPLalzeJ c0IdEAC7EnPgFrX98wvkeRIDRuNk+3wpYF9PxGyGw4yonzFiKP0vJlcheK+o5RjqpHesOiqgeGH R0XehjqP51nc4az49mRjX5mfYYjVjjTJ1qqviemgR1g3176ktmnthyBR1VDPeOTUyICl1Pgl/pX veY+7npMuIKEGzLPNLxf1I4xth+abf2RhJaDZOsox3OSs81djzSqGBT+n4pSjyphPTh/fDjxT8Y qoMBovl8/p0OCgQL//pe/3pORafwo2gMpeTmjfYzYiP2nIidhC98buTvK3RU6ywY1mmZfzeRG5B U2fPhKJ3HL4jZ5dNowpoG0pfzkICqFEqjNaRCr566viGpl8UjYQIO+qH+LfPjNd4aGrGQmJqALa Hzh/GiZXe/eES5tCY6WYTQ1NYAnvtI0I2JC3QIKSjkKdbeR/uB2vWQ1DG1aSebF/hSZu6rIXtyq Dy7KfFuTftND3YOXK4zeC60JOsqAZCWWQBnVGR+ilA439w/CsJ6g6zdVvVquj9lTYBeN3qsEAW8 vS27EGM2rBff+ttHifpepkQBKxDbMMz5vVkUiXnlWc/oFMPi2hAFoVHvg2I6ltGd68fbk3I2P9L 3AhWTRUv+3Pteg1eKhK9eeoMCN0Q/Su6bcrZfe3h7M4aJ/+5IYTBkuUn9J5uZXXCa0cTKSS2VfG yb/5JcXDzgqRTfQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We can easily drop the BUG_ON()s from the audit_log_XXX() helpers and
simply return to the caller as we do if we are passed a NULL
audit_buffer.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/audit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index dcc657d35776..d05c92d74361 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2016,10 +2016,9 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 	struct sk_buff *skb;
 	va_list args2;
 
-	if (!ab)
+	if (!ab || !ab->skb)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 	if (avail == 0) {
@@ -2084,10 +2083,9 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab)
+	if (!ab || !ab->skb)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 	new_len = len<<1;
@@ -2117,10 +2115,9 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
-	if (!ab)
+	if (!ab || !ab->skb)
 		return;
 
-	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
 	new_len = slen + 3;	/* enclosing quotes + null terminator */
-- 
2.55.0

