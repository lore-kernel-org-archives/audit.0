Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA9C77B73
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 11:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEXLhd (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 24 May 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXLhc (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 24 May 2023 07:37:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A2C5
        for <audit@vger.kernel.org>; Wed, 24 May 2023 04:37:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso826381e87.0
        for <audit@vger.kernel.org>; Wed, 24 May 2023 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684928248; x=1687520248;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vr6//6AMhQmMq7Ipt/o5aA6gaMHLtvyO7iK3eSQGiY=;
        b=smPjO3vwSwE65ONbHUCELd+G2GyxqxHVOmNyQnhNShdW84KXFVm8E+0eB/ByOmeunS
         EP7Rqie67fONVCRAatTttoprvdRO6tCTWPYeeyElPAuOlTVlMRNdwrgnEQGML87rFlSV
         TVga2eNhbzV/nfsF6huxcWAsa7khk/wDfUjYbjhWwMrxWQ1C0IXPrx95anYzreNlRH7j
         gx501nCiSSOoHHgOEgVTk5VfXVmepnY8Bp2+qxqj1kUkthX3x1T5UugKzSRFtkVxqji5
         Pu0VicfyVOiUc80RawVecWKcPgspiMYF9oNuFP9tjcPjklrs90foczViZC6na84+YOid
         NzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928248; x=1687520248;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9vr6//6AMhQmMq7Ipt/o5aA6gaMHLtvyO7iK3eSQGiY=;
        b=E3nMAINj8FekKmm/MW94W56rzfHO2mjPjMTEngyVWc8Vxr9DfYUYzdCv5P0eLDfp65
         EApdnpzmTye6+Ae6X4kTptaAuXdX9gtcUIMCkuQotJVQtyt+DiYPfrITaAZSZKrg/eg5
         039OJvd/9Qwud20k2Q11kbsX79Khvw/cTcXXyI3XX+vQAHwMqELYZpXVRQ+qo1Es1A6h
         z1r6EYXZaf1FkIP2wiv3avdcLrYhC5cU+DSkllRkjnMIYeja0T3OFfcGqMfpMhgxGSvD
         u3xk9iA4dsXYzzYREc1xtLqArwS7T74lUZ6J5hU1s/3DHvuKjFdfBT9yoHxYNqItJDDn
         VmGg==
X-Gm-Message-State: AC+VfDzTjIy6Tt8lDz72VMsdcSetDcst5xt9Ogjgt2m2IlfPSHtvpBI7
        iQiGraiepOwMkIl5tJ1E7rufwk/G86a+jg==
X-Google-Smtp-Source: ACHHUZ4/IVliRQ0C5P9g6J5Cs/0+9WOEJP23ZhxklzoYIaX3pHzY07bLXcOhF9PzHeolM4QqwcPqdg==
X-Received: by 2002:ac2:5a4c:0:b0:4f1:4e95:119a with SMTP id r12-20020ac25a4c000000b004f14e95119amr4856253lfn.12.1684928247999;
        Wed, 24 May 2023 04:37:27 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.185])
        by smtp.gmail.com with ESMTPSA id d20-20020ac25454000000b004f4b3e9e0cesm901441lfn.297.2023.05.24.04.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:37:27 -0700 (PDT)
Message-ID: <b5e87a11-7605-6745-516a-8004569bbe5d@gmail.com>
Date:   Wed, 24 May 2023 14:37:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US, ru-RU
To:     linux-audit@redhat.com
Cc:     audit@vger.kernel.org
From:   Rinat Gadelshin <rgadelsh@gmail.com>
Subject: Auditd doesn't receive syscalls after installation for the current
 shell.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hello there.

It seems that the kernel doesn't send messages for syscalls of the shell 
process from which auditd is installed.

Reproducing steps (performed on Ubuntu 22.04 x86_64 on virtual box by 
`root`):

step #1: $ apt install auditd
step #2: $ auditctl -a always,exit -F arch=b64 -S openat,renameat2,unlinkat
step #3: $ echo t>delme;echo t2>>delme;cat delme;mv delme d;mv d 
delme;rm delme
step #4: $ service auditd stop
step #5: $ ausearch -f delme

There are syscalls from /usr/bin/cat, /usr/bin/mv, /usr/bin/rm but there 
are no any syscalls (openat expected)
for /usr/bin/bash (current shell process) for the file.

If step #3 is performed from another tty, then openat syscalls
(CREATE for the first echo and NORMAL for the second one)
is logged for the /usr/bin/bash process.

`uname -a` returns: Linux grin-vb-ubuntu-22-0-4 5.19.0-41-generic 
#42~22.04.01-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 18 17:40:00 UTC 2 x86_64 
x86_64 x86_64 GNU/Linux

Should I open an issue for the case at 
https://github.com/linux-audit/audit-kernel ?


Best regards
Rinat


PS.
At first I had the same problem with my service that listens to 
audit-netlink.
Then I just checked out the same scenario for auditid.

