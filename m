Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FBC83F10
	for <audit@archiver.kernel.org>; Thu, 31 Aug 2023 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjHaOjJ (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345247AbjHaOjI (ORCPT
        <rfc822;audit@vger.kernel.org>); Thu, 31 Aug 2023 10:39:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4141B1
        for <audit@vger.kernel.org>; Thu, 31 Aug 2023 07:39:06 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579de633419so10425287b3.3
        for <audit@vger.kernel.org>; Thu, 31 Aug 2023 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693492745; x=1694097545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLZrBGnLZs2pRE/KvifoHn+CI1rpeJi7JyyHMepmqgM=;
        b=FvrK4swDnGvUYuVuoNu5o0D9A0NACoS1nnj00F8F5s6eWxDqUt/oGBAz7tSob04ZSy
         BrtCmckxSNPPHmKSlants6I4jaAltMI+MGld75JHhW62RSD58JTllLvaAleGoSsbiNuK
         stvGhJ7gyO7SD1VWrp/7EJ8l+qWHnWaCiRpu/vqPlo5Q4G5ZqhJkFZhbNCi7SzvuKdLm
         TsTukIvy348JFWul6X2SIyytSh2KmYq8EmZ8zrzkceIQOtcexIltet3aiO+PZ2KsoY/e
         hC1uhQ7CrW1e9oazL53JT2T8Z52z+B+fX3zkHfDvIu6mXOPOGZ5FzhTBs3i7uZk4Ds44
         +ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492745; x=1694097545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLZrBGnLZs2pRE/KvifoHn+CI1rpeJi7JyyHMepmqgM=;
        b=gS8Gig8MA6w/EcyVdG117KAiFtAudr9ARsO0ZP/o9awFXiDGbeaBwJy8i9BJUe9XQN
         OkgY/3poRaJEO6d3NO6vsjmwKS+BYN7/n/bwBqBTxzUuRcNk+zBOWDGdDUMR0ANAWLea
         KZpcXtK1PT5juigcQDXA5l2267KV4rGvcCdvuKc0WuSG8pk255auukVh1G+0MNdfbZ+e
         8kvHzrKTKZX1Y5OIQiptEns9Su1IGJi+HfzMTjk0sPP296pmhFBIfo+CSAmoSN0LgDV4
         92BkFaS2cJH0+Gc4ZRugC0VQNsEdeqsrTTIQ9ZEeEPEY6LplI4Vw2ls3awgyaVRODqyj
         ZRyg==
X-Gm-Message-State: AOJu0Ywpdh9kge+0i+rbi7+L78IDVsAqweLW/e2Q96L7sQovh9VNgtJQ
        KVz245oorKDACIPeejfryedYkyxpEMEp8Ux5qdZ7mlAQlxSd4Kk=
X-Google-Smtp-Source: AGHT+IGlvktnyds773cVOckzfrRiCq9Hr2UGcPh7WhbuB2zn1wCLypOEdnosfpZzT+35z4FMVFwhUXHkoDfzjbfWDDs=
X-Received: by 2002:a0d:e606:0:b0:595:973:b4b5 with SMTP id
 p6-20020a0de606000000b005950973b4b5mr6195696ywe.12.1693492745139; Thu, 31 Aug
 2023 07:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <202308301248.hEwyeVEl-lkp@intel.com> <CAHC9VhQZFZTaXb_S5YCy9KniVfPBmEQrY74_dMi5cBftZsrwNg@mail.gmail.com>
 <4d8308622a1513099fe461ed41409c3768d95946.camel@intel.com>
In-Reply-To: <4d8308622a1513099fe461ed41409c3768d95946.camel@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 10:38:54 -0400
Message-ID: <CAHC9VhTjb8E0GUVNbdbgR2wzbXaGYFYZ6gNSMns+TF1muRA3+A@mail.gmail.com>
Subject: Re: [pcmoore-audit:main 1/1] README.orig: warning: ignored by one of
 the .gitignore files
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        lkp <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Aug 31, 2023 at 5:33=E2=80=AFAM Liu, Yujie <yujie.liu@intel.com> wr=
ote:
> On Wed, 2023-08-30 at 10:29 -0400, Paul Moore wrote:
> > I have no idea if there is a person attached to any of the addresses
> > on the To line above, but please send audit kernel issues to
> > audit@vger.kernel.org and not linux-audit@redhat.com.
>
> Sorry for the inconvenience. We've updated the bot's email
> configuration to send audit-related reports to audit@vger.kernel.org.

Great, thank you!

--=20
paul-moore.com
