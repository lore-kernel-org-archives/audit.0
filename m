Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDEC001B0
	for <audit@archiver.kernel.org>; Tue,  8 Aug 2023 20:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjHHUNh (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjHHUN0 (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 8 Aug 2023 16:13:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF58B288F
        for <audit@vger.kernel.org>; Tue,  8 Aug 2023 11:45:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7659cb9c42aso434902985a.3
        for <audit@vger.kernel.org>; Tue, 08 Aug 2023 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691520320; x=1692125120;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5aYMTcQVpXzmH3xfi0RCZlbyutuYpAt8Mczgei2TXuo=;
        b=M/e+VuCA5g2Q224YnBwRMZBKgHTy/NIC8o/en+DjPgp/IiCFV6+aoqlnCIZ61i5tnJ
         6gTlOasdg6mj2sghgT2Gh/ZVwNd+X6RNwbnvz3b+AOfxt1YWpcYy6V/PXsjaPgAiIM/I
         SY1hj7qO7257VcaTtwhOtB7NVsoxCdU9w1T+ECN5dslRkblROdEqQz27o5r8iTS3kWmF
         sVNVGTIzJ4ptY3FtzL7/w3O7Jqiauasv4ppfJSzQjRDhGKLwt3dDtlFBjfuCfC2HsitQ
         NJSUTf54WG7PJxnXuTx95Mx21Kr39WbnK4pU04gsy/LNRobOSIn7E8xUrjPQaGBlr6cB
         uZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520320; x=1692125120;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aYMTcQVpXzmH3xfi0RCZlbyutuYpAt8Mczgei2TXuo=;
        b=NByVRqwNJh5HIWL3rTwZzeaBAQHguLWJui4RahzQ7dZN5LtFYjgnMsB7G4TMT7ZKiq
         lGG9TI82ABmo87uLCtMey7u+DBSTTDDqD8y+6iWO3AN3fPTL2arPlZLZg9k4+3sOkNRr
         plu9SYN0R3Jb4pS0sBntVTY9vsdEfkck1CIampseN7JxenssOGCHL1NA72HXhVAT8+HL
         ZE9AoaywRQrcVz5NRZHzUk+JArAVxhruMhjPm6nvDdr7r2PmYSvoLKl9MfR/PBZrRwVr
         aBAwn551fsi/vm6f3StkLPfl2Zz6AgwHZ7cMmdH+l9fkOuy1JqdrJqBuFuwcFUhBMTew
         2wLQ==
X-Gm-Message-State: AOJu0YzYv8G3+JxYBPymze7uGk5lL+Jg6hYukgYtNr2sNhyMxO0lqrnP
        Ta8G/jcp8sPIwGwZ9SfL/Ri9
X-Google-Smtp-Source: AGHT+IHkfh1ELUQPP3D7MQLqpUe4f617DdSmqu1dI0al8Mexag64ChlHETMceuYsR52aladsTy6UKw==
X-Received: by 2002:a05:620a:b82:b0:76c:ea3f:9010 with SMTP id k2-20020a05620a0b8200b0076cea3f9010mr519762qkh.16.1691520320213;
        Tue, 08 Aug 2023 11:45:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v17-20020ae9e311000000b0076729e726cbsm3480412qkf.22.2023.08.08.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:45:19 -0700 (PDT)
Date:   Tue, 08 Aug 2023 14:45:19 -0400
Message-ID: <e86f8bee54444c5b66c5e5c3ade51c7c.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, <cuigaosheng1@huawei.com>,
        <eparis@redhat.com>
Cc:     <audit@vger.kernel.org>
Subject: Re: [PATCH v2] audit: fix possible soft lockup in  __audit_inode_child()
References: <20230808121435.1118761-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230808121435.1118761-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Aug  8, 2023 Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> 
> Tracefs or debugfs maybe cause hundreds to thousands of PATH records,
> too many PATH records maybe cause soft lockup.
> 
> For example:
>   1. CONFIG_KASAN=y && CONFIG_PREEMPTION=n
>   2. auditctl -a exit,always -S open -k key
>   3. sysctl -w kernel.watchdog_thresh=5
>   4. mkdir /sys/kernel/debug/tracing/instances/test
> 
> There may be a soft lockup as follows:
>   watchdog: BUG: soft lockup - CPU#45 stuck for 7s! [mkdir:15498]
>   Kernel panic - not syncing: softlockup: hung tasks
>   Call trace:
>    dump_backtrace+0x0/0x30c
>    show_stack+0x20/0x30
>    dump_stack+0x11c/0x174
>    panic+0x27c/0x494
>    watchdog_timer_fn+0x2bc/0x390
>    __run_hrtimer+0x148/0x4fc
>    __hrtimer_run_queues+0x154/0x210
>    hrtimer_interrupt+0x2c4/0x760
>    arch_timer_handler_phys+0x48/0x60
>    handle_percpu_devid_irq+0xe0/0x340
>    __handle_domain_irq+0xbc/0x130
>    gic_handle_irq+0x78/0x460
>    el1_irq+0xb8/0x140
>    __audit_inode_child+0x240/0x7bc
>    tracefs_create_file+0x1b8/0x2a0
>    trace_create_file+0x18/0x50
>    event_create_dir+0x204/0x30c
>    __trace_add_new_event+0xac/0x100
>    event_trace_add_tracer+0xa0/0x130
>    trace_array_create_dir+0x60/0x140
>    trace_array_create+0x1e0/0x370
>    instance_mkdir+0x90/0xd0
>    tracefs_syscall_mkdir+0x68/0xa0
>    vfs_mkdir+0x21c/0x34c
>    do_mkdirat+0x1b4/0x1d4
>    __arm64_sys_mkdirat+0x4c/0x60
>    el0_svc_common.constprop.0+0xa8/0x240
>    do_el0_svc+0x8c/0xc0
>    el0_svc+0x20/0x30
>    el0_sync_handler+0xb0/0xb4
>    el0_sync+0x160/0x180
> 
> Therefore, we add cond_resched() to __audit_inode_child() to fix it.
> 
> Fixes: 5195d8e217a7 ("audit: dynamically allocate audit_names when not enough space is in the names array")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2:
> - Add cond_resched() between the two loops, thanks!
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into audit/next, thanks.

--
paul-moore.com
