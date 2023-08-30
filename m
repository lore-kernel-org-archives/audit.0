Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3BDC83F15
	for <audit@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbjH3S4i (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbjH3OaA (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 30 Aug 2023 10:30:00 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C138193
        for <audit@vger.kernel.org>; Wed, 30 Aug 2023 07:29:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58e6c05f529so67216737b3.3
        for <audit@vger.kernel.org>; Wed, 30 Aug 2023 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693405795; x=1694010595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NghURf49RK5ylycOOwon5RzRxws9/PW8JtsRCxfmiyY=;
        b=GlU9Ev03642guN4/Jn7jNZTv6ST/+oyvo/iBvz4zboyB8W5Sq6eyLK4in6pXyevVex
         MovcqbtCVS5wS00UA0SSunqRIWVt5vLgQNqY6MFyB4PEUfD/YaNpxcHkm+dfYL69pkWL
         1EjQwIn0PkvbtCngJuWEwv/wxisNUN8Fhm0+DOe1vZfuC2lxfNuQJplv8LMndP8F1FM7
         OiibdWRR+pibuW2BbahbTzcWvWeebJrEHeMiMWB32JtdrUs+qhdG0rK9x54G1Wz4i5x0
         3AH/FAGZIbIIq27W3j7Sotnbx/3DaPjO4DUtmM9VYIwP0be0FB/1UBmmv/cEpoIj7euA
         do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405795; x=1694010595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NghURf49RK5ylycOOwon5RzRxws9/PW8JtsRCxfmiyY=;
        b=gz6zyZwfFXV8WCHZYpk+A2lQQGYTYMPh5mtzIUUaxEM2BJfCjhpwu6daF6SIUVEd9X
         NonLLUBVcnFHwWXVdjjI1zKvQJG+Yn9LfkeKjv3o6pWb9+3qckrarLssCqG5XWQUrN5r
         qvxAqaKaKpL5d1ummYT1YDe5YU9jaoQkD6g7+iRl0ZB/vTKa9b7GrseK/eFiR2Cc5u6B
         FVwccx9Miu2ZuUAGd14NLKakn6qyv/3jRP/KIVFrA2GAy+KZ14yDe/B+rpBC3yyithXO
         etAzbYD7f0WvwBawGpEmsGWeMdLm9LvJ+kr5/UAMHTuHOe/NENH8RGFRmN7W+r+vhq2Y
         7KyA==
X-Gm-Message-State: AOJu0YynqjhRpGmVi37IWPIvGObUEGKx8UMVolr2HEtVkzpe+ElhhnFk
        OYgx/DXS5XDlXMLkB0mPvMcsYlF/R452cjDq72+2
X-Google-Smtp-Source: AGHT+IENUcGV1zmTTBYYJ4iI6kb1uCtEbWSrgnMVUQ/8HiTd3flLhgpR3sz66wZeZ1ViiieOOnosB8xqzoOlplCZg5w=
X-Received: by 2002:a0d:f747:0:b0:595:80e4:907d with SMTP id
 h68-20020a0df747000000b0059580e4907dmr2056857ywf.32.1693405795614; Wed, 30
 Aug 2023 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <202308301248.hEwyeVEl-lkp@intel.com>
In-Reply-To: <202308301248.hEwyeVEl-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 10:29:44 -0400
Message-ID: <CAHC9VhQZFZTaXb_S5YCy9KniVfPBmEQrY74_dMi5cBftZsrwNg@mail.gmail.com>
Subject: Re: [pcmoore-audit:main 1/1] README.orig: warning: ignored by one of
 the .gitignore files
To:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev
Cc:     linux-audit@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Aug 30, 2023 at 12:17=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git=
 main
> head:   94e5ef9b157c6c3779352a8d4121542f71de52a1
> commit: 94e5ef9b157c6c3779352a8d4121542f71de52a1 [1/1] audit: add a Linux=
 Audit specific README.md and SECURITY.md
> config: parisc-randconfig-r012-20230830 (https://download.01.org/0day-ci/=
archive/20230830/202308301248.hEwyeVEl-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230830/202308301248.hEwyeVEl-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308301248.hEwyeVEl-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> README.orig: warning: ignored by one of the .gitignore files
>    tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of=
 the .gitignore files
>    tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one=
 of the .gitignore files
>    tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one o=
f the .gitignore files
>    tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored =
by one of the .gitignore files
>    tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by on=
e of the .gitignore files
>    tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the=
 .gitignore files
>    tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .=
gitignore files
>    tools/testing/selftests/kvm/config: warning: ignored by one of the .gi=
tignore files
>    tools/testing/selftests/kvm/settings: warning: ignored by one of the .=
gitignore files

I have no idea if there is a person attached to any of the addresses
on the To line above, but please send audit kernel issues to
audit@vger.kernel.org and not linux-audit@redhat.com.

Thanks.

--=20
paul-moore.com
