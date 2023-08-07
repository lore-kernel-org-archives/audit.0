Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFCC001DE
	for <audit@archiver.kernel.org>; Mon,  7 Aug 2023 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHGSdB (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHGSdB (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 7 Aug 2023 14:33:01 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721BE66
        for <audit@vger.kernel.org>; Mon,  7 Aug 2023 11:32:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58451ecf223so52502707b3.1
        for <audit@vger.kernel.org>; Mon, 07 Aug 2023 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691433179; x=1692037979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DwT6HerT6Lu25BgfYUiplLTxVRCMpVNvN+t33qSU1k=;
        b=FttOddX5ydWcCNN1/2qyJtq+/KIWYP915AMnPIDu/pCjaEzVGPHsyMixgRd3/KRpND
         raAtL94hig5HqeR9tLU7uCIgN9CkfHeIfd/kncWulW5sqO3nVRkbngnaZc8SgmRHCvM7
         Qy6naybSC65eUFVSW2aCGZfw7cJi6F4jjKjE7kj90t/+WcbwIOI7nQhlxUt19KKtykyr
         Mq907JbUzWDkZe1IuWu7F+THZOBr6lEig7cmRHcE3YzacQkUU2Uijrkp6g3blCTt9Ty/
         VsN9NKLrjXyX8QwYj8lSqe68oejLCSoM4zzfpXPlC8bpgOn9oTE+A11RALuTEyuSiSv+
         NdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433179; x=1692037979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DwT6HerT6Lu25BgfYUiplLTxVRCMpVNvN+t33qSU1k=;
        b=DAH7fSx3XjfoUIo3K7B0YXLeDisLhCnd12SjjfTig8RuYlIuUBZe/2MN4mldq/HfPz
         kXAoqS0fZf1z9XDecKJv1Fgw82D8MV4a8WvZmI9QceREEjpBmufYMaK5J/1HAEhHL0cw
         CWPyyKABf6lw7P3W6d3Q+TPsCMAakgOLLqAbWaBfmXXSbi80+cyYFs6AAT+YOFenigKB
         m+UpY0bq8BYARq4RsHxl60APrIMCsRLqm6l0QGp6exy8M61I/zQd5esw0e/vK7Nq0x8F
         dyQSEZQ0HR4+I2CyOUuGsnaaM7AqqZVdneiiNptJtaAzob3RnI7zgEkEUc5XgxpvCyDJ
         MYcQ==
X-Gm-Message-State: AOJu0Yyc+6BkO8FSPXtmj3rma0PqB4f2pJIPCTY9iw2TxcRpZCSZg306
        9+TyFfxbCdCwYlTJ/FxtzmsYmoZVFSJo32KwEtZ81YhHUOUh20XCt18r
X-Google-Smtp-Source: AGHT+IFB/B0LfYnM8ryyLA3hWrSFFadN1WGRYCuddHJLZWc3+a3bt8lfpxTtRZmDnQBw6FVNjIExx+MjPsbLp2JWpEo=
X-Received: by 2002:a0d:db08:0:b0:583:b802:d207 with SMTP id
 d8-20020a0ddb08000000b00583b802d207mr10118679ywe.43.1691433179045; Mon, 07
 Aug 2023 11:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230805023934.347828-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230805023934.347828-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 14:32:48 -0400
Message-ID: <CAHC9VhSxFiuNd5uFoZf23GRKMQzLbjaLWZw57B7pO0WcrwMW_A@mail.gmail.com>
Subject: Re: [PATCH] audit: fix possible soft lockup in __audit_inode_child()
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Aug 4, 2023 at 10:39=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
>
> Tracefs or debugfs maybe cause hundreds to thousands of PATH records,
> too many PATH records maybe cause soft lockup.
>
> For example:
>   1. CONFIG_KASAN=3Dy && CONFIG_PREEMPTION=3Dn
>   2. auditctl -a exit,always -S open -k key
>   3. sysctl -w kernel.watchdog_thresh=3D5
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
> Fixes: 5195d8e217a7 ("audit: dynamically allocate audit_names when not en=
ough space is in the names array")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index addeed3df15d..fce37545644b 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2454,6 +2454,7 @@ void __audit_inode_child(struct inode *parent,
>                         found_parent =3D n;
>                         break;
>                 }
> +               cond_resched();
>         }
>
>         /* is there a matching child entry? */
> @@ -2473,6 +2474,7 @@ void __audit_inode_child(struct inode *parent,
>                         found_child =3D n;
>                         break;
>                 }
> +               cond_resched();
>         }
>
>         if (!found_parent) {

Exactly how many PATH entries were there in audit_context::names_list
when you ran into this problem?

I'm not sure we want to jump immediately into putting a cond_resched()
into both loops, especially since tracing/debugfs is a known corner
case and the default kernel.watchdog_thresh value appears to work
without error.  How about adding *one* cond_resched() between the two
loops?

--=20
paul-moore.com
