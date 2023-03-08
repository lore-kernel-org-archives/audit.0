Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E82C64EC4
	for <audit@archiver.kernel.org>; Wed,  8 Mar 2023 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCHRQC (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCHRPB (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 8 Mar 2023 12:15:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4685A92C
        for <audit@vger.kernel.org>; Wed,  8 Mar 2023 09:14:23 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q189so10023876pga.9
        for <audit@vger.kernel.org>; Wed, 08 Mar 2023 09:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678295658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C4QbkTIySwqscLQzr0NbRA+gpTbL4KU/7BAF7iiRrw=;
        b=d6iXcbzcv5bZJBfySqbwD4u8SjRrp99o6qUv5viLdScKK95xQ0JkItKSafCwXvwm+G
         hAHMu/GReDpI9DtHR1NQHReQtp6sVOiSKq2+7EU8UiLeIlG6SaxhsqYEr0pGtDv+vHGs
         zEHcE/6bL1SlJb2Ma9p6oo7f/B2L0oK/5mYUiW6c5S6csltFvLFz60h4SxHIixsfftL/
         hRQISOPG15vnPObEV2ZwlTG34u10fEe49yHEBt1ApEjwAT06YGI7on3lAkSHZeJ8SvsX
         EKVO2VJkE2AbOAbyPFVR1+HvXveJ1KZg1+C2BOdDNhSA5h1fnfh10kfSPkQ053eT4Nu0
         S6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C4QbkTIySwqscLQzr0NbRA+gpTbL4KU/7BAF7iiRrw=;
        b=J50GaPGYv95PP6UPS/3jKCtJ6iETUW2oW6Kw4Td44TfOEuPYT+SqSTZXyh3qbCljq+
         84JWz6adDWRviO+DVfeP+n1mxgHxLwl8n+ljiZCzkcfI8eqIpCxGURiOJL/BTLin/m5B
         M/hKllNOHBetRnuc9GBwSxuQbnNod/nkON5ABzJ8bsSEptjkb+MrG8asdgTpXjL+tyKB
         nCrYqua4EycnhwOmFoB7CkdCMlaAx1LtW2XBj7FJLRFyU3q7bTavHFnp0S1MqONkW0HR
         N3KmeoDhiMOyxktBR24b25c1XDLigSMLHZUithFoHDxuHBo0DHZQjUyPE9rXm38UIilN
         BVnQ==
X-Gm-Message-State: AO0yUKU/mQKGm+zoTzVzJFtjBLf8JbnxsAo3qChqFJC2cGwCZu1NKp9R
        32vdEpSb/d3z7ksYtifUCChnNIZUADB/2xmyYn0K
X-Google-Smtp-Source: AK7set/BpoJJUKbumOMSL8kfveopYzcrd+4A411g/jVIOMCdKT9WFOtJB520LAiwzjkb0/gz0W0mo6+82wPZAFerKzQ=
X-Received: by 2002:a63:fd41:0:b0:503:a7:c934 with SMTP id m1-20020a63fd41000000b0050300a7c934mr7635173pgj.2.1678295658226;
 Wed, 08 Mar 2023 09:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20230307122524.2341659-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230307122524.2341659-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 12:14:07 -0500
Message-ID: <CAHC9VhR55ygtwzV758j3B7JCMUD2ya-imKdxawZNb3mTMOKYuQ@mail.gmail.com>
Subject: Re: [PATCH -next] audit: refactor audit_log_cap to improve performance
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, Mar 7, 2023 at 7:25=E2=80=AFAM Gaosheng Cui <cuigaosheng1@huawei.co=
m> wrote:
>
> By testing the performance of snprintf on qemu, I found that
> snprintf("%s", str) performed much better than snprintf("xx%s", str),
> the former takes 2ns while the latter takes 60ns.
>
> Based on the test results, using audit_log_format(ab, "%s", prefix)
> instead of audit_log_format(ab, " %s=3D0", prefix) will get better
> performance, so refactor the audit_log_cap() to improve performance.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index addeed3df15d..d04d0a57a603 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1295,11 +1295,12 @@ static void audit_log_execve_info(struct audit_co=
ntext *context,
>  static void audit_log_cap(struct audit_buffer *ab, char *prefix,
>                           kernel_cap_t *cap)
>  {
> +       audit_log_format(ab, "%s", prefix);
>         if (cap_isclear(*cap)) {
> -               audit_log_format(ab, " %s=3D0", prefix);
> +               audit_log_format(ab, "0");
>                 return;
>         }
> -       audit_log_format(ab, " %s=3D%016llx", prefix, cap->val);
> +       audit_log_format(ab, "%016llx", cap->val);
>  }

Have you specifically measured the impact to audit?  I worry that any
improvements gained by using snprintf() differently will be lost by
the additional audit_log_format() call for every capability logged.

--=20
paul-moore.com
