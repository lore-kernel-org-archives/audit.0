Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95098CD37B0
	for <audit@archiver.kernel.org>; Mon, 18 Sep 2023 15:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjIRPXF (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjIRPXC (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 18 Sep 2023 11:23:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71AFE
        for <audit@vger.kernel.org>; Mon, 18 Sep 2023 08:18:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4121130e7afso30173011cf.2
        for <audit@vger.kernel.org>; Mon, 18 Sep 2023 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695050305; x=1695655105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+rwWAiyWkYsrlyxNSv91+CBw+J/bXlaoTOByMLCFCM=;
        b=bMr4y5LcFDlLPuN9QO59/qKWx55tnnmpi+o7MN4F+1hIoo8XnnDjATeaq0qjmb18gu
         FyNwJRoXs0IalON1b4vlZaEITg/facOkXjMZRkIFm3/HsIwvckZ54Yi2qNOyQPeihopu
         8IcGYe2FdKaYS418gwITn+7JYp09bURocJZNyS4U6MDvVYOLThTs/QU3tWyECyWlBSE3
         mTx4jVFw2SZYcui0IC8hmftqauCe9+v61mESCxElsiP2lIgVoFcZRB0dISsLfkJR15oE
         0rcox0IkEJRlG+92WILiihvV0n8SUebBQozMoXHKoNI0ub39fmaEM5BlFOYJChsCkrQx
         GjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050305; x=1695655105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+rwWAiyWkYsrlyxNSv91+CBw+J/bXlaoTOByMLCFCM=;
        b=scVe/uVDFjnYhPrl5ygdlKEIsAebSuK3T/nnn244+nfM7cvCXZYJGVmzpx/gvuaolM
         qAqvCIFDMP1rl4lTVKTmf6McfA7GDpgqmvZXk90Wgh+PyR1CzgRb9TiIWzXWNIWPiRId
         EgzVs81jkT2kU/OdMyv0gzOECdiYJ/fYQLyYW3Id13HW7iSKzZaIpErclZcVGbDAijdG
         gKzP5UXPQF/Tux+dLjljAq3LaIhAc49iwYqzKCgdpqafNlKpczRP18jOPexzys9RJDES
         lWHIPVc1uvbcrXUXZRNOR2v4DUN4VSie9NETGubN2Ew3o2aOcgsbVKLI0H0tKWTepDSf
         V5eQ==
X-Gm-Message-State: AOJu0YzgCrKMg90Y3mxkHWq8m1mj5zoNBwbaMXC2hqwzAH0XvR7Zos3t
        Nnuam5bBmJBpVzIRvtMtQvoiKZMaVm5fhXWP+hIeX79YnsrxC8A=
X-Google-Smtp-Source: AGHT+IG/l2EhKA7j6MQ7/zJZOQZAp9ewc4tdE7Y1QLbMN3JUoQ/OgnYbsU9kTtVp6rKLcq9S7ubDJjk0SmaS5L9ikCY=
X-Received: by 2002:a25:8244:0:b0:d12:1094:2036 with SMTP id
 d4-20020a258244000000b00d1210942036mr8045189ybn.43.1695046628012; Mon, 18 Sep
 2023 07:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_NsVOwDre+jfcOyWDDaML5VJxudyP1eP_Wucg_vU=iCrA@mail.gmail.com>
In-Reply-To: <CAFQ2z_NsVOwDre+jfcOyWDDaML5VJxudyP1eP_Wucg_vU=iCrA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Sep 2023 10:16:57 -0400
Message-ID: <CAHC9VhRytcvW27FEPg+QGaMXbS8Fsz_-YMkJQ7_P1hE=fSm5sg@mail.gmail.com>
Subject: Re: Reducing security.capability xattr checks in audit subsystem?
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     audit@vger.kernel.org, Jose Lopes <jabolopes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, Sep 18, 2023 at 7:20=E2=80=AFAM Han-Wen Nienhuys <hanwen@google.com=
> wrote:
> Hi there,
>
> I'm troubleshooting a performance problem in FUSE filesystems. At
> $DAYJOB, we have a number of FUSE file systems used for development
> (eg. serving source code), and we have an auditd configuration so the
> security team can keep tabs on nefarious activity.
>
> We see that the audit subsystem generates copious xattr reads for
> "security.capability". For FUSE, those xattr reads are passed back
> into userspace, which is expensive because of the extra context
> switch. In our case, the FUSE filesystems universally reply ENODATA to
> these reads. It looks very straightforward to change FUSE to
> optionally filter the xattr reads in the FUSE driver, but I wanted to
> make sure that that is the fundamentally correct approach to solve our
> problem.
>
> We can see that the xattr is read for all manner of files, including
> directories. When I read through the source code, it looks like this
> originates from get_vfs_caps_from_disk()
> (https://elixir.bootlin.com/linux/v6.5.3/source/security/commoncap.c#L654=
),
> which reads the capabilities regardless of file type or mode.
>
> Has anyone ever considered making this conditional on the mode or
> filetype? AFAICT, both are available at this call-site.

I would like someone to double check that the only time the file
capabilities are used is when it is a regular file and marked as an
executable, but if that is the case I think it would be okay.  We
would also want to ensure that we have proper logging when the file
capabilities are changed, regardless of the mode bits as one could
modify the file capabilities and then set the executable bit.

--=20
paul-moore.com
