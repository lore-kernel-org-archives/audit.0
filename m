Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807BAC77B75
	for <audit@archiver.kernel.org>; Tue, 18 Apr 2023 13:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjDRNTv (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 18 Apr 2023 09:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjDRNTu (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 18 Apr 2023 09:19:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759D167EF
        for <audit@vger.kernel.org>; Tue, 18 Apr 2023 06:19:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u13so29138209ybu.5
        for <audit@vger.kernel.org>; Tue, 18 Apr 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681823987; x=1684415987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBnC5mM7IRjKgDTtiT1xO0lGo5nu3wZ3UZ7UhsqhPt8=;
        b=EesxlTC4t3WRpgD8mYrwdUWbYXQbyjYcjqG1AFdlIIoIz8dCzf4Qwc9oJcsSlxoNsM
         yTcBLKg+zLa5XkedtRFcrjDGhBldFyYhQzh849hbXX2WZEgzmwJWK/5Z5KnPzkkjirU2
         z5cHoqrIzr8ov/DP21CQ83vSZKvopvgDpfEztmGo8DeS4ZOzfxCf3PhGZzu7qXIhla7N
         smiy8A4C08P/+TIzqyrmg0MTjHNqLynvu5LRUNTlq16xbOEaVg8aREmFYhBAVaP5wHPK
         FwYTCjcGRU+qKVDNX0HqKF34JWggYo+KmE71tN1ksvOkkUZJP5Q6hIJVef4jWdXYLquK
         74gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823987; x=1684415987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBnC5mM7IRjKgDTtiT1xO0lGo5nu3wZ3UZ7UhsqhPt8=;
        b=lZkPXRHKegNjKzvMr6UEfA773e2V4vzTM6BHyK3tnK1D6LkCerK+VTHn9ZRPlHoURe
         Zll+wSJMK6HU3SmEFm9i+p1951aHxao/y7IL7hrVdzE+rho4zhfPKgRwjs+0Y5IZbgu3
         Y/gcqqieYuGuvIfVtm7Yp2iwKRF50zLK7SEG99q1HNk5ursflYBveexqeyzA1rmmvY7s
         3e8ldmaad6w/Vymc343nhv157D1uk63XSxihASGFoFyzBlsKOB4wJ0bBsvmobRGZ0UIa
         KgOLfHqd5irB/giiOffE3oh/wZSsQL+qqBf6ICYPYAZrtR+tqM+L+1BaQoU729R54iSH
         lYlA==
X-Gm-Message-State: AAQBX9d7WCwV7aHFtFmLsuUVDN9OQ2XNjqPwG8aRqEgYs8MYV3TB/shd
        +h/nqW3YFU1vIJjneXzkI5cVq6KrIvzR1eFSQ3f912Lmfs8PXWE=
X-Google-Smtp-Source: AKy350Z6+iEzLZbxHCluPTabOdwCDIahnihVezPoiKD2wQm/6fTMj5hbeSY+F4irIaAGbDlAkwuvkUSiS89bGSAmvek=
X-Received: by 2002:a25:d7d3:0:b0:b68:7a4a:5258 with SMTP id
 o202-20020a25d7d3000000b00b687a4a5258mr12186999ybg.3.1681823987160; Tue, 18
 Apr 2023 06:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230418110919.221578-1-eiichi.tsukata@nutanix.com> <20230418110919.221578-2-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230418110919.221578-2-eiichi.tsukata@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Apr 2023 09:19:36 -0400
Message-ID: <CAHC9VhQO8bSdbFYszvjWNT1GCCBr8yusDEq1f52akJApXq8kGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] audit: add global auditd_pid to make
 auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, Apr 18, 2023 at 7:10=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
>
> auditd_test_task() is a hot path of system call auditing. This patch
> introduces a global auditd_pid pid struct which can be used for faster
> check of registered audit daemon.
>
> Benchmarks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Run the following micro benchmarks:
>
>   (1) dd:
>     dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
>
>   (2) UnixBench syscall:
>     ./Run syscall -i 10 -c 1
>
> With rule:
>
>   -a never,exit -F arch=3Db64 -S uname
>
> Results:
>
>   (1) dd
>     Base line    : 2.572 sec
>     /w this patch: 2.418 sec (6.3% faster)
>
>   (2) UnixBench syscall Index Score
>     Base line    : 860
>     /w this patch: 953 (10.8% faster)
>
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 39 +++++++++++----------------------------
>  kernel/audit.h |  4 +++-
>  2 files changed, 14 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..9426980368e4 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -71,6 +71,7 @@ static int    audit_initialized =3D AUDIT_UNINITIALIZED=
;
>
>  u32            audit_enabled =3D AUDIT_OFF;
>  bool           audit_ever_enabled =3D !!AUDIT_OFF;
> +struct pid      *auditd_pid;

As discussed previously, I want to keep the auditd tracking PID in the
auditd_connection struct.

--=20
paul-moore.com
