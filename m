Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZVf9c7ZF"
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31BBB6
	for <audit@vger.kernel.org>; Wed, 15 Nov 2023 09:25:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so4262017a34.3
        for <audit@vger.kernel.org>; Wed, 15 Nov 2023 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700069145; x=1700673945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jD+a9n1X/m/OP/ZG5r/zXxGgLeZdEEIXH9Rn/eAZW4c=;
        b=ZVf9c7ZF0i5woI1vRAhCB8qui864l/d1FLXy8q6NdUYgI73vUYp7Je1WvhAppQWtJ7
         52DrM0AkEpv+Pc+IgOk9QPitza3y1j4y+e3r9Vv0lZsEvdxEv2x6Z75Dks6EOUoxfChr
         YnHDxkkhy9FrVcteo4aw4Dscfq78Yiht9hbeNDIaxOn6d2dDXJvK44tZ5aIgqN+o6/qg
         0T04FhNe33fSg7gHxenXXzHAIabFnpC+2K4sKkdkDDy2tcCWzggn2MMrz7m328GZKfMS
         i76/3zFaMDy/2UxpuDCNnIRVEUtx3+oRrEeDTEeB68cObZBp6LK/Nchld0tR9kHtuU35
         XPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069145; x=1700673945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD+a9n1X/m/OP/ZG5r/zXxGgLeZdEEIXH9Rn/eAZW4c=;
        b=taxdDeAmiQyYx80iZDR/98wRhAX12mJZyHL47DZi5U0ceRV9A7ykzOOags6r8Kft/z
         8L/8XcKnjrK0flmXQ74RN9tjExIqeuWhzN3ObTvbfzDMVYQPs9K63iW6GbQ2DZnXquEh
         25bmZvLyYFKW1aFMHN5fh1+BNDCrcn8WGUSVLz47LS/waSctGO+5jTMkbm7PUm1RyQKE
         gYfmuLQgNOiHAHCvhAuAD9wRMTL+DmZjhniP3BJmvED05sCl9QM0SkFpfM3bzQuhrwf6
         eB6gGRiIbLASRkgNhMIacwine/Mw2H6pn+75wWH8j6aBQ/CzW+Kd5SgqfjjtMfsGiXAz
         Nwzg==
X-Gm-Message-State: AOJu0Yz9W6cCbXD+hltuEufF6ECgRCfAnlbY2nx864GUcpyb8kFCu9BN
	ow5axPUld6pAMj/34Nn1N1QY9qEP7/1hs5Q14Q==
X-Google-Smtp-Source: AGHT+IF9hkMyamhM3PZ17ch0dLqHQkKmj40YPjE1RW1ZpC1sNwVBlLbJf349cYkhdhnx60RWGhYROQ==
X-Received: by 2002:a05:6870:d14a:b0:1ef:b4ae:e2a3 with SMTP id f10-20020a056870d14a00b001efb4aee2a3mr17714055oac.5.1700069144813;
        Wed, 15 Nov 2023 09:25:44 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l25-20020ac84cd9000000b00421bad3d029sm2971092qtv.24.2023.11.15.09.25.44
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:25:44 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: audit@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update the audit entry
Date: Wed, 15 Nov 2023 12:25:38 -0500
Message-ID: <20231115172537.130415-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=paul@paul-moore.com; h=from:subject; bh=zmHCI26v4EGTiWHTv3JR3X0OSHhusVrDuXYB31vnt1o=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlVP8RQDqRNHCNWMg8Xc8YJVmFNR1sTURuLXpXx bFx6P/M8vKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVT/EQAKCRDqIPLalzeJ c1FBEACPmBum1voPv9SBtCcNegeaFwd0bVtbP/OmCJGgpsW6uBovPYDsU6sKGaU2vV1iE3SEs2R RHzSIMJYCgy21H45/1ST5NmPkV2NuQSsDnDU370zJ/BDcdiizZA5EUxzkBv2RqsF5XkTgfRyqbT mcnU/FKXOSfBleMLybGFmoDVXAb6GFB3Aw+cP6MCxmnUOUy/vHI1EolEBxKZ7uoOLs7X653g/KA 5taSpy1kJXwqWMmV26f90p+B52OJmlG0bNz9ViNidrOTGiDfJMsGIoUjyLXkMMn04mFqnnIIYpy 6lkAJ4VLVlfWp3CBj/Ma/OA46syVNOQTcgM7r1V0vFw5dt9CoK+M1gUkoUcDMetpBTfmQr+2j4S SD2Iwocph8kLmUKEvLKWGjqUo/vSJk1r5L4973MKSXLNDH1zl6zS9A4Q9LoXsi6rWPIIECozE/9 79hbjpUS1iUilj1ShF89Nr4oHvMiE4s1Q3QJFb8FJyO7cJ/GQb/EGstm26a3ZMkIqXj9zvJio0y S/kDJbVDUTfGa2P9y7RAz/t8i9B2H/2wpAVOR94rG2Q3CrQ6OJi0LWeyHlcMrOix/4PbCFTcvNl mntTgGuRWb/6YYXEf6dR+yMO4H1rtXoQIckq3vJ2UojTUaswJqBahk/4HzgrIwdk3zBlqXuzAi3 Grbif3CIWWfStoA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Bring the audit subsystem entry up to date with the following changes:

* Add our patchwork link.  I'm not sure this is of much use for
anyone but the maintainer, but there is a provision for including it
here so we might as well include it.

* Add a bug report URI.  I suspect most everyone knows to send mail
to the mailing list if they hit a bug, but let's make it official.

* Add a link to the audit tree process/management documentation.
While the doc exists both in the canonical kernel.org location and the
GitHub mirror, provide a link to the mirror as GitHub does a better
job rendering the Markdown.

* Update the source tree's git URI to use https.

* Aside from changes to the audit code itself, we also would like to
be notified when the audit call sites are changed so we are adding an
audit_XXX(...) regex to try and catch all of the callers.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..bb967a494400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3350,13 +3350,17 @@ M:	Eric Paris <eparis@redhat.com>
 L:	audit@vger.kernel.org
 S:	Supported
 W:	https://github.com/linux-audit
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
+Q:	https://patchwork.kernel.org/project/audit/list
+B:	mailto:audit@vger.kernel.org
+P:	https://github.com/linux-audit/audit-kernel/blob/main/README.md
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 F:	include/asm-generic/audit_*.h
 F:	include/linux/audit.h
 F:	include/linux/audit_arch.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
 F:	lib/*audit.c
+K:	\baudit_[a-z_0-9]\+\b
 
 AUXILIARY BUS DRIVER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-- 
2.42.1

