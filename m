Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F166C6FD1D
	for <audit@archiver.kernel.org>; Fri, 17 Mar 2023 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCQUsn (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCQUsm (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 17 Mar 2023 16:48:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B043B863
        for <audit@vger.kernel.org>; Fri, 17 Mar 2023 13:48:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o44so1356336qvo.4
        for <audit@vger.kernel.org>; Fri, 17 Mar 2023 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679086110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWvpSSJk6zgR7avSJU+aR2VyZwKcT5jdHYPIUkp/VOk=;
        b=KeeMgmroUck1uup8DanwCGNLu4gxwVY20vKUUGSYh/dKVZP7oWuq72ZzqJTJjwAK1h
         5zvrMyAsRA6/aQEzv+3RS8hggALCu5N0dWfvax6BnfLvZgT3SrxIAnTj3X/CLTOJRw2e
         CIBz+9s+oq0sShQGhfT0Q7ZrTaUmOed8Kzi3W7eW0JkkTNe3AWV9TBQhUq/4WgJRED0c
         9H5sCYt4FMTfKakV3vLMbm6+TVCMx81+4NC7DLIBHjg5XYoamEV++NcP3UjHOxOPpfGV
         zEk68iWShKy8nTb/EbW8Z6/QTyKSCOxHP76QjxQfywMyazVw9vlqPDLVN8yzrAWVd4mP
         ntdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWvpSSJk6zgR7avSJU+aR2VyZwKcT5jdHYPIUkp/VOk=;
        b=hxEgUndIVpUK5WGzw3Y+8hzRqU7uXNUQOVSW7uKs/9E5ybdoWXHgHR8BMPoQpAWkx4
         RkdpGMiqQ0+FICrTdALufkjJgVIbC3qjMTMK9t31f7gPSeL3IiZHNVtfJg/NcPzzshOQ
         ckALj/Q5kt5AstX6aHl+RKNVy9pXnCqQUo6VwoqTvuXEFo3ACnXv8EQfkaGLOOkO95eO
         wcp9EDK9T3y8GalMolawuJcIwcXoVbLGhD3uCB5yqxpOhXxGGF1M8eG70FPce46zBTVJ
         G9B+XazGLqugEncjJYkSD+vAOffvsYQt6n+Vpt8g8gOIwcgVrcinCRbmeD5B9lNmGi0I
         9djw==
X-Gm-Message-State: AO0yUKWQN+mHmWQ40Xb0knp8MLTpZAoU2NTyVIksmnycmxkAh/XIP1dr
        J5uc4JaXC2biAqEh9eLq63mZhi6O6pdY2al91Q==
X-Google-Smtp-Source: AK7set8ACRtlaZB1mATI2kh6T1pU+yMvxNLMOXh+6aM+DP+l2wXdN6mUGYJmODpgDjb2zw7vy/L8Hg==
X-Received: by 2002:a05:6214:19cb:b0:577:5ffe:e0ce with SMTP id j11-20020a05621419cb00b005775ffee0cemr46373218qvc.25.1679086110475;
        Fri, 17 Mar 2023 13:48:30 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b00725d8d6983asm2329938qka.61.2023.03.17.13.48.30
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:48:30 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     audit@vger.kernel.org
Subject: [PATCH] tests/io_uring: set a filter for the io_uring ops we want to catch
Date:   Fri, 17 Mar 2023 16:48:29 -0400
Message-Id: <20230317204829.328126-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Without an explicit io_uring filter in place, we might miss the
io_uring operation if it happens asynchronously.

See the post below for more information, examples, etc.:
https://lore.kernel.org/linux-audit/CAHC9VhRMJq1gJPoR79AxM1JphmGtxhGMYBkd=Ptuaq3WBjX2Bw@mail.gmail.com/

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/io_uring/test | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/io_uring/test b/tests/io_uring/test
index 9eb427a..df13af0 100755
--- a/tests/io_uring/test
+++ b/tests/io_uring/test
@@ -49,6 +49,7 @@ system("auditctl -D >& /dev/null");
 # set our io_uring filters
 system("auditctl -a exit,always -F arch=b$abi_bits -S io_uring_setup -k $key");
 system("auditctl -a exit,always -F arch=b$abi_bits -S io_uring_enter -k $key");
+system("auditctl -a io_uring,always -S openat -k $key");
 
 # run the "t1" test
 system("$basedir/iouring t1");
-- 
2.40.0

