Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F8C77B61
	for <audit@archiver.kernel.org>; Fri, 28 Apr 2023 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbjD1UdD (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjD1Ucw (ORCPT
        <rfc822;audit@vger.kernel.org>); Fri, 28 Apr 2023 16:32:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3881FDD
        for <audit@vger.kernel.org>; Fri, 28 Apr 2023 13:32:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-552d64d1d2eso4564817b3.1
        for <audit@vger.kernel.org>; Fri, 28 Apr 2023 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682713935; x=1685305935;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHhiJldyAU9CB5C2yY0Y6C22LzUDclV05l5l/CDs2wQ=;
        b=fTg0otBIRL0I1iKj8EZY5jTYL6865p+WLycjm3WPpj0UdoTL41jtIQSV8Lgp4+kR4v
         IQyuRqMgb33VBaC6z9J6SCq2EfWfTUmuEFpfzjqRG+YkrfiztLKjvihGZ+oBtvwKmMhz
         J98d+R7AXjzEUAdyUeLXm57RO0MQM2ojbAO8T4wNUdAbjNy3Hx2CXREVym3ihx8+pfCQ
         1VJqdmREr1WV54hOO9hIWcLU79//OIjab1jGDp1/jUvCQAoPDp4+SWoResB9l2lIVMHh
         MuZHe3yCFGQ1uT/T/PG5hESHIWYXLqaBcgTtiLbNNx+BWdATdRv1TiTC2/qon3HCeOJs
         ItLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713935; x=1685305935;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHhiJldyAU9CB5C2yY0Y6C22LzUDclV05l5l/CDs2wQ=;
        b=Q2NzGg2DNYOpcI3W47H9VMQwFoLE2bdgOUTGDi/xxPyh6lZd5TGwGW6zGdfftYf7nA
         nDnH/fRH8MXWR53NrrfkwTxUUFGBGgT8upaAS6vwUIUXQVl8zK1cfgjPhKhzaqjf2jPQ
         mEySySvjZ8+BfLlNGvpKRpyMyxOJLWEQRO0ApTtn0FS6hLAYx7XJ53PWhiN+S/jzEH5T
         At4unEBPgEm5q9CsueWkqmES/Z2eP0Oa5cH/ezrY2iGHezbs6DFtP6jm9sPcPx4+j4qv
         hf1JleDBNh4DPVxKV7NXLigFw2xbs4hyykck8RE9OPafnY5kzzPWPdRmZMCD092L1Tus
         ZF8w==
X-Gm-Message-State: AC+VfDzPuuLZ1GKF3t5+WJH5g+WMbZqq1Z0m+gCdtopgGkeL2dQbc5Dm
        1XHcr23FD8oCrA93GrfdK2rvrVo1I5zWlLzroyJgnl0wCkrFw0o=
X-Google-Smtp-Source: ACHHUZ7IyujZgDo19YnXrzNdSyty5RiiNjuJFjSXu5yI0STKfDSGMMYYGNXnM2egCVO8/xqDuHMDNBj1QG9SWcFPw04=
X-Received: by 2002:a0d:d68d:0:b0:552:9fc5:ebb4 with SMTP id
 y135-20020a0dd68d000000b005529fc5ebb4mr4535577ywd.42.1682713935067; Fri, 28
 Apr 2023 13:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230428203007.651380-1-paul@paul-moore.com>
In-Reply-To: <20230428203007.651380-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 16:32:04 -0400
Message-ID: <CAHC9VhRqALJq+-L2Q9TFuqJ7FTu8rJSFwAD53dNZDiqh=fOMXw@mail.gmail.com>
Subject: Re: [PATCH] tools: update astyle config for astyle v3.2.x
To:     audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Apr 28, 2023 at 4:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> It appears that '--indent-preprocessor' and
> '--max-instatement-indent' are no longer supported command line
> options, remove them.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tools/check-syntax | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/check-syntax b/tools/check-syntax
> index 03bca8a..eacd92d 100755
> --- a/tools/check-syntax
> +++ b/tools/check-syntax
> @@ -69,17 +69,14 @@ function tool_c_style() {
>         astyle --options=3Dnone --lineend=3Dlinux --mode=3Dc \
>                 --style=3Dlinux \
>                 --indent=3Dforce-tab=3D8 \
> -               --indent-preprocessor \
>                 --indent-col1-comments \
>                 --min-conditional-indent=3D0 \
> -               --max-instatement-indent=3D80 \
>                 --pad-oper \
>                 --align-pointer=3Dname \
>                 --align-reference=3Dname \
>                 --max-code-length=3D80 \
>                 --break-after-logical < "$1"
>  }
> -

Ooops, I forgot to refresh my patch after fixing that whitespace removal.

Regardless, I've merged this patch.

>  #
>  # Generate a properly formatted Perl source file
>  # $1 - source file
> --
> 2.40.1

--=20
paul-moore.com
