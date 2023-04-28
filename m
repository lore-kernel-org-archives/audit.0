Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1030CC77B61
	for <audit@archiver.kernel.org>; Fri, 28 Apr 2023 20:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjD1Uaw (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346220AbjD1Uav (ORCPT
        <rfc822;audit@vger.kernel.org>); Fri, 28 Apr 2023 16:30:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F644B2
        for <audit@vger.kernel.org>; Fri, 28 Apr 2023 13:30:15 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-5f16be5dccfso3548716d6.2
        for <audit@vger.kernel.org>; Fri, 28 Apr 2023 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682713808; x=1685305808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Ww98b9bo31yJrtBS2ioi2r9loAqw9zBYZPEj6NKXY=;
        b=cz1N+L4LXXL3cpekMYNOh78HlUAaY8kRnT8mGMLIr+qGabRd2nyEUVCweetzSDMm4Q
         umBeLnn/FKdGomEdbF4Zsb6mfmYeilBuK/DRIpS4hsL5ontdpoKGgCr8NPviSYnipEyF
         2NiSIHmGabjuzc0RAEDXTaPUxliKJIg43tWbWmWOd4vUQddmPtO7WDWqJNyDnEB5Yd4T
         IV+aMuM5l9XXAoaO5HK+PaSLj2mYRC6ymxDYcSPCHPGlfTYEXtN9KggRI3R+kxPCCCpC
         tnmP5WHqs3VPqkwFRZykt4au0TZ7kJuXRcxTHFRHI12lFhqHz0EYmyMNQftpN+RNp1jn
         e1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713808; x=1685305808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Ww98b9bo31yJrtBS2ioi2r9loAqw9zBYZPEj6NKXY=;
        b=W41iGnka9Y6/qP3BQm6ciE8knAzWdxaSey0j3CWeBLMdtfC7f2oPQtifUpk9BnGxQw
         oZ1gI6QDSnOtPUu3uPAn8aYG9RkSLL+JTpxA1VfzPdgkImOt84/vxlFBG3eT1+2rJ2d8
         46CF6VzyFV1SZ0SNLMDtSAGvC0TLYIn5REF9iijb3ur4qawsd+YvoTBPtAsCnbD2lBVx
         nJ7AjktQscy/yVQl/N7jPU93jHemmKpbEUKLKyMncwTI1c32tQ9PCggk0W8+gY7PVIl1
         gOxcj8qIC13c9peivl7HGGn5KOctSqOHu/whliqQeFBvsnz4UErtXezqHjn9tEnWJVvW
         W35g==
X-Gm-Message-State: AC+VfDwcFybE5Nlb4+S/Mt/NgY+7/sNd3exz5R7hqyexvICxeADdTwMv
        68Hr65s2vHJVCfmVF8O6XA8e6ubtio3BNdQ2ow==
X-Google-Smtp-Source: ACHHUZ41Zj2alMw3Bm16ZzGm4lgwu3UffVPzSRxf6QDxF/H/h28d8ugjCuv6ciVF38uNrj9/Xk0kBQ==
X-Received: by 2002:ad4:5962:0:b0:5ef:8c85:6c67 with SMTP id eq2-20020ad45962000000b005ef8c856c67mr9196434qvb.52.1682713808539;
        Fri, 28 Apr 2023 13:30:08 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b005ef593385e3sm6630443qvb.1.2023.04.28.13.30.07
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:30:08 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     audit@vger.kernel.org
Subject: [PATCH] tools: update astyle config for astyle v3.2.x
Date:   Fri, 28 Apr 2023 16:30:07 -0400
Message-Id: <20230428203007.651380-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

It appears that '--indent-preprocessor' and
'--max-instatement-indent' are no longer supported command line
options, remove them.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tools/check-syntax | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 03bca8a..eacd92d 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -69,17 +69,14 @@ function tool_c_style() {
 	astyle --options=none --lineend=linux --mode=c \
 		--style=linux \
 		--indent=force-tab=8 \
-		--indent-preprocessor \
 		--indent-col1-comments \
 		--min-conditional-indent=0 \
-		--max-instatement-indent=80 \
 		--pad-oper \
 		--align-pointer=name \
 		--align-reference=name \
 		--max-code-length=80 \
 		--break-after-logical < "$1"
 }
-
 #
 # Generate a properly formatted Perl source file
 # $1 - source file
-- 
2.40.1

