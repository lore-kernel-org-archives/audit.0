Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA3C7618A
	for <audit@archiver.kernel.org>; Mon, 20 Mar 2023 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjCTQB1 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjCTQAZ (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 20 Mar 2023 12:00:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D343E0BD
        for <audit@vger.kernel.org>; Mon, 20 Mar 2023 08:50:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54184571389so231888787b3.4
        for <audit@vger.kernel.org>; Mon, 20 Mar 2023 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679327434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhjG4ZM6bbphuME8qaGD16strmVMS/zUs25lWRzLtgA=;
        b=dlozo6eDyj+uKp8vllmx4CyQVtNo/1tF0nzhKwsifzKUEIu1zPG2t0WjTdp0eHsn7O
         J0Hwvar8Www3EhOSZVMxEHUKlIqP0NVVYhrYKbT0eo0JrddUJ6YG2m1XpozStFjl9p6G
         phvBXrB7k0HQGL/OIE1bsOIz13QEjU6oghreLdTUBBLIVqgKI/vBCFdyjP8MQog+wF6G
         jnaMT5wU73RkLpLgiZQpQ9TG2l0Tl6dOC+7ktSl6wmt9CvqCuotslYCfschaL7gKP9G7
         ZfE0DN7y3dokkiiNFy8DOXyoAnn6RQgRntfI/Srcw7eE1Fkzh0k0stT8SCIIpRP1lMBD
         cVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhjG4ZM6bbphuME8qaGD16strmVMS/zUs25lWRzLtgA=;
        b=pu52zbQffz2dahM5f/7ld18hXqjuvFvjNdNiHKbTNXAUHwkLEmat2S1R7N05fdMeTU
         nwcXsH1g27Hi5+bLsdzd26fF9yQO+ddJ2Tvhg9D/vtLt47aZeDv7OfPRE1G47PXgQ7U7
         idcHhb6VeV4lcNnfBoCaRLLl87EV5+pEhrlMAwbvxQ2CP70g+GgqQKFcLM/2D/dkjNQK
         qldmHDup89VWLJ52Z6zn2mfUincBhsKp6U6P9Eu8+D0N5rJoG4EWoAk/PUjI4uctElFn
         K9pwYIdIPlL+11UgSNF269+DIbBSGgOcuab1yCg8+PfECfRY/g3u9gi3qFUKAusjB4tW
         N/xg==
X-Gm-Message-State: AO0yUKWmYNpmc1Rnz8FbZQbVoG5358CaTyqlqnNjyDKYAO367ZFlRc33
        +JRVr2m28YHQ6saOYu+jCSN1jg1scrJCDFX1qcsvVAfWkUCfVJTNKw==
X-Google-Smtp-Source: AK7set8EHCVdzLcDk90+JtEnsZChSS0fog0skAl1a9UITDtzyJdC8DccLgmPj+vA2ozpkmyfwYaErzOdzIqRO9ANpzc=
X-Received: by 2002:a81:d302:0:b0:541:359c:103a with SMTP id
 y2-20020a81d302000000b00541359c103amr10221044ywi.8.1679327434420; Mon, 20 Mar
 2023 08:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPoNrtsy+ckCHQZGYM-8DW3S3FckABGyZtvVG3LJPDT8PLzMUQ@mail.gmail.com>
 <CAHC9VhTPYw_YprXkZ2h-XAg3WGsqkTxBVzZiyo0XOaRmmeC71w@mail.gmail.com> <CAPoNrturZV58xESCvCOg5PQbHkf0reJvAbbLJ6-fJa003xxnjw@mail.gmail.com>
In-Reply-To: <CAPoNrturZV58xESCvCOg5PQbHkf0reJvAbbLJ6-fJa003xxnjw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 11:50:23 -0400
Message-ID: <CAHC9VhSBbvE0GuLbrWmCgQyJc0KY_-MYrXYG08SjMp_7QYJnpg@mail.gmail.com>
Subject: Re: Help with setting up Auditd kernel repository
To:     Anurag Aggarwal <anurag19aggarwal@gmail.com>
Cc:     Linux-audit@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, Mar 20, 2023 at 11:09=E2=80=AFAM Anurag Aggarwal
<anurag19aggarwal@gmail.com> wrote:
> >
> > Can you be more specific about the exact repository?  There is a
> > repository which contains the development code for the Linux Kernel's
> > audit subsystem, and there is a second repository which contains
> > Steve's audit userspace code (which contains auditd as a component).
> > There is no combined "auditd-kernel" repository.
>
> Yes Paul, the repository that I am talking about is:
> https://github.com/linux-audit/audit-kernel

[NOTE: The upstream Linux Kernel discussion has moved to
audit@vger.kernel.org, CC'd on this email]

Thanks for the clarification.

If you aren't already aware of the Kernel Newbies site, it's a good
resource for getting familiar with the Linux Kernel.  There are a
couple of pages which I believe might be helpful here, the first is
the guide on building the Linux Kernel:

* https://kernelnewbies.org/KernelBuild

... the second page is a general landing page which has links to other
kernel related guides and resources:

* https://kernelnewbies.org/KernelHacking

These info on these pages should help you get started but if you have
any additional questions let us know.

--=20
paul-moore.com
