Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD4C77B6E
	for <audit@archiver.kernel.org>; Fri, 14 Apr 2023 14:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjDNOo4 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 14 Apr 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjDNOoz (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 14 Apr 2023 10:44:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A783D2
        for <audit@vger.kernel.org>; Fri, 14 Apr 2023 07:44:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id by8so2838706ybb.9
        for <audit@vger.kernel.org>; Fri, 14 Apr 2023 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681483490; x=1684075490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFfbL1uh84j9xAURtkr7szI6BF3AAYp2+zwUT6jEQ6U=;
        b=EYtip8WWBJQoX04+52+MVKW/KhiIr2LTzrmtuKqHP6PvHKOzSvl3muC9uUU/3ng6jC
         DFYHzJajx6mxHCOVTYUEmZ3BXRhMtJIPZaF27zw3/pmCX8FhgDoXvhVFFb+a8domyEys
         8/7IgRTQbquDsMoN5K/L7DNry/C+2N5HtHQ/qU6toJ+Qf7OEyDH39TBdXeF9llzOL9dL
         Wg4Y/4emvGnaU27ill+c0zb2euKsmGJukzIyRcgrH4PGkVXEluolDc676jk65gJo1gIj
         hsKIUgqCiEi5O15YIAKLQ/EWuXn0gJAXXN5s70/AE0YSSSf/HSwGcTVzQ3+cAnnrX1ZX
         9Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681483490; x=1684075490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFfbL1uh84j9xAURtkr7szI6BF3AAYp2+zwUT6jEQ6U=;
        b=YBlhPdlSATdz0ptsS4Z8GUpeC59Ub6p6Xa3nT+JGionlZoE7KvB/PeEKstbm+mwPUY
         z++oI72ebq7gFKinUEYPvaZuANpmz+FiYroaYE7KTwzGFIQAV+8hXrNGKkCyryVoXcqQ
         0/9TxXqHlezyF9nCJxKMI6vN6JLW2Q8dx2BJ0R0A6RjMKyAuUBcii65zekL9aKDsAE97
         FV9lh0DULoA0wJlnCIzav8TsL/z/F7mSLWtCEiCgO200Ez8Argd4gEIlUO99t/vJtLPY
         NAIWRqUgSkrlKzaQ5D2Q+jEFbKMejIuCx3w+z+Od9U8h/ttj9lqBRzKNka5cOLHZLJya
         MEfw==
X-Gm-Message-State: AAQBX9e4TNa5jS8ONuN9Wj4NJxUlWmh4pU70zeKe7RWoLOtZGtpJHfyt
        APWZFi4v+DYyYIz8+5zW9evfSyq3dglVCQHHWPzD
X-Google-Smtp-Source: AKy350asV6Ywm6W48mRTCbkqKaalljOMXFrkeb1KrorvpTIeczOiKumCux1SnY7bxHWSAm+yqPTMaetSdh6Tdy7oQ3I=
X-Received: by 2002:a25:d14e:0:b0:b92:258c:e409 with SMTP id
 i75-20020a25d14e000000b00b92258ce409mr374295ybg.3.1681483490661; Fri, 14 Apr
 2023 07:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Apr 2023 10:44:40 -0400
Message-ID: <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Apr 13, 2023 at 11:14=E2=80=AFPM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
>
> auditd_test_task() is a hot path of system call auditing. This patch
> introduces a new bit field "is_auditd" in pid struct which can be used
> for faster check of registered audit daemon.
>
> Benchmark
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Run the following command:
>
>   dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
>
> With rule:
>
>   -a never,exit -F arch=3Db64 -S uname
>
> Result:
>
>   Base line    : 2.572 sec
>   /w this patch: 2.412 sec (6.6% faster)
>
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  include/linux/pid.h |  4 ++++
>  kernel/audit.c      | 22 ++--------------------
>  kernel/audit.h      |  3 ++-
>  kernel/pid.c        |  3 +++
>  4 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 343abf22092e..5fe38e254c9a 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -68,6 +68,10 @@ struct pid
>         wait_queue_head_t wait_pidfd;
>         struct rcu_head rcu;
>         struct upid numbers[1];
> +#ifdef CONFIG_AUDIT
> +       /* registered audit daemon tgid */
> +       unsigned is_auditd:1;
> +#endif
>  };

Thank you for the patch, but I don't think we want to add an audit
specific field to the pid struct at this time.

--=20
paul-moore.com
