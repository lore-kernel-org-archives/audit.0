Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2EC76196
	for <audit@archiver.kernel.org>; Thu, 23 Mar 2023 15:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCWPlW (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCWPlT (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 23 Mar 2023 11:41:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611320579
        for <audit@vger.kernel.org>; Thu, 23 Mar 2023 08:41:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5445009c26bso401602537b3.8
        for <audit@vger.kernel.org>; Thu, 23 Mar 2023 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679586065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOyaF+gGSN9Akn8RPiykCCXnGXj+bPsBBzE63MFeUT0=;
        b=PcqEt6tMp0xjQlClBpC72hn2b3nPWVJFe2AWqBc7b1W3X9xj5mlfKca/F1KERRgZ2L
         5qcL8OFoILfnuQ/nkpd6y0lhuukuerHTl+tuhbu9wfJOHqrL+O14aikeCRONDt4Hw57f
         NYu4E7n80awW932FdvAZCmqC3DzzJ5g9rm08joZhrTIdEHa81feZQ+qgu4Eho2gck+z/
         SszGmb7x17Zv5HVjQUe9n2IaA3YUalrsBirO1NcQXxri1Q7ytaOdCiwNNvF1iO6GgGAQ
         sVnzQ7wLOufPqRSHKmp4I41G+9gGWCC3mjVvSPwbVDTQ3rfylnIdHOaIVq0G9TFSsay0
         /n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOyaF+gGSN9Akn8RPiykCCXnGXj+bPsBBzE63MFeUT0=;
        b=AOqi5g3VOSTsDMfZL+4oHNI09+xNQrbum3WvxCbJvuObuUY8zSCcx0JMEHhDgmN8Ke
         Y52/jEW3cqrEDxDOWLQ+a1qHr7T5o/GANsnxu+Xarr3EnwpqmmvkY/x6LzX74DexTyH4
         o3gONCJdjJ4nLVIc3Vp2GitRedJXLaYxomxqdmRznJNUWaSKmAyb7wgiEWrtKWrSftJJ
         0IprcjBIs3d1JAeVqzb1+Hk374BwKOhU7Gm+7YF6ntM3m6FdFZdzYgi6Vtsve/5oj6sa
         D9uQ6zUjzccmEy5Y60CgsdUZV+MG3ZMWGaugJmgDplle9+DGGm7xq28kkLMNlcYl7JJP
         pAqA==
X-Gm-Message-State: AAQBX9fX+q7GzD0PM87mYeLiwjVPg9b0K5hqwzNu/+Fx/O3tLwnGlO0e
        vJ1aHgkysVqzBsx3nrODol3vLTUXfyxNxEAMtpfD
X-Google-Smtp-Source: AKy350boiOKWMqFPwkW/HxnLayUF70c7EaL/DyOQve15sUlREYRrYMz087FAeAvDMIvGBxdGZo+l8gvHxZ8XqfTCS6s=
X-Received: by 2002:a81:e20d:0:b0:541:8c77:93b1 with SMTP id
 p13-20020a81e20d000000b005418c7793b1mr1993199ywl.8.1679586065284; Thu, 23 Mar
 2023 08:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230317033733.1450702-1-cuigaosheng1@huawei.com>
In-Reply-To: <20230317033733.1450702-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 11:40:54 -0400
Message-ID: <CAHC9VhS1Q9Ks_TYjxRe=S8L7kOXS5tuhLV59OA=fnAXN3q3fJg@mail.gmail.com>
Subject: Re: [PATCH -next] audit: let the caller of audit_get_sk() ensure that
 net is valid
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Mar 16, 2023 at 11:38=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.=
com> wrote:
>
> The caller of audit_get_sk() must ensure that net is valid, otherwise
> there will be null-prt-defer, for example, in the netlink_unicast().
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/audit.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..6a42a3801d01 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -285,16 +285,13 @@ static pid_t auditd_pid_vnr(void)
>   * @net: the destination network namespace
>   *
>   * Description:
> - * Returns the sock pointer if valid, NULL otherwise.  The caller must e=
nsure
> - * that a reference is held for the network namespace while the sock is =
in use.
> + * Returns the sock pointer. The caller must ensure than net is valid an=
d
> + * a reference is held for the network namespace while the sock is in us=
e.
>   */
>  static struct sock *audit_get_sk(const struct net *net)
>  {
>         struct audit_net *aunet;
>
> -       if (!net)
> -               return NULL;

I'd prefer to keep this check in place, and I think it may be required
to ensure proper behavior in kauditd_thread()/kauditd_send_queue().

>         aunet =3D net_generic(net, audit_net_id);
>         return aunet->sk;
>  }
> --
> 2.25.1

--=20
paul-moore.com
