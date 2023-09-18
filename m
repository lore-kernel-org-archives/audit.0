Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36383C46CA1
	for <audit@archiver.kernel.org>; Mon, 18 Sep 2023 11:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjIRLTq (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbjIRLTP (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 18 Sep 2023 07:19:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14867B3
        for <audit@vger.kernel.org>; Mon, 18 Sep 2023 04:19:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a645e54806so544175766b.0
        for <audit@vger.kernel.org>; Mon, 18 Sep 2023 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695035948; x=1695640748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EtpuY97tqFVxHIsr98zqfy9W7YzZxoL2wqVuLvO54qM=;
        b=v7PjQcax6bevehWrkTvv9VH/4CvvrVk7XE3S2/3bVNQpo3Cl9o87X5c5zYTANCGmHv
         lhdDH9iL/EUxd+Y/FHvDVD+AwBRAHooQPdZdBt01AB4Ycnr8Bq6UqEUn61sDEhgzKzgV
         VDqA+g5SeylrFI0jZIcP98pTZYDJIzouZ3lvOx3PuHU9kt4plBx4bxoDNbl8R+URA6u7
         1gzhO4cWFCjzMWxILaT7yyDNC9aY+GWbN8XTJBZettSz/Xwgv1S/DxwmbKr7GnJpSgkf
         gno4Lo+3gvOaacKNjq2RjFvjSa/GdhNNQMyfDDKos5LHRT595v45tq5xe3zrYKgP6u6L
         OrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695035948; x=1695640748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtpuY97tqFVxHIsr98zqfy9W7YzZxoL2wqVuLvO54qM=;
        b=HOb6scs5ZewkJlFPUcWvpUgU/9/GNRiK5LDeWXo1UnKaMFfiI+6XATiY0N4mmLAtx+
         6wO09ipkCk+31fBFkgbKeb5Gb2ashPfUu+je+W9X9aS4WHVzyl5hBON/SWvz3h94aT+O
         Z1CMFm27rgAP2yMAKoWaIXJSmX6YE6YzbAZ8rreS0QYMbAoZrtRENbkJjjmTFYejehTN
         FpoOeYyyQeUunZeb254k2PzKhZbOGBj/gn+R6OXox+mXRrToUgUzGYC0bTki2kudNcWG
         Fw3LJswtRQZG3SMXn/kaSCpMTvNlKXsR28i9W09wq8+qg1SB127Yryf1J1dpdw6B4jB9
         vj4w==
X-Gm-Message-State: AOJu0YyZ2s0uufm7k9ohgG8agO13Fr9Ku9K4JUJ59DzBv72aCLum65EB
        M3JvdmnkBEqSuBTMq1FRkPUAsb1Y11qpFq27dW/tgpuskcsvjkRhg1Agkw==
X-Google-Smtp-Source: AGHT+IEUaGeLB31O8u04x8T9H+SGhhbTVkImzFIEYOo85khOjymKkAJOkLdHt+DV/eskM/j2ZnFqKk6Ho1iU4QPZFco=
X-Received: by 2002:a17:907:2c5b:b0:9a2:120a:5779 with SMTP id
 hf27-20020a1709072c5b00b009a2120a5779mr6900381ejc.60.1695035948032; Mon, 18
 Sep 2023 04:19:08 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 18 Sep 2023 13:18:57 +0200
Message-ID: <CAFQ2z_NsVOwDre+jfcOyWDDaML5VJxudyP1eP_Wucg_vU=iCrA@mail.gmail.com>
Subject: Reducing security.capability xattr checks in audit subsystem?
To:     audit@vger.kernel.org
Cc:     Jose Lopes <jabolopes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi there,

I'm troubleshooting a performance problem in FUSE filesystems. At
$DAYJOB, we have a number of FUSE file systems used for development
(eg. serving source code), and we have an auditd configuration so the
security team can keep tabs on nefarious activity.

We see that the audit subsystem generates copious xattr reads for
"security.capability". For FUSE, those xattr reads are passed back
into userspace, which is expensive because of the extra context
switch. In our case, the FUSE filesystems universally reply ENODATA to
these reads. It looks very straightforward to change FUSE to
optionally filter the xattr reads in the FUSE driver, but I wanted to
make sure that that is the fundamentally correct approach to solve our
problem.

We can see that the xattr is read for all manner of files, including
directories. When I read through the source code, it looks like this
originates from get_vfs_caps_from_disk()
(https://elixir.bootlin.com/linux/v6.5.3/source/security/commoncap.c#L654),
which reads the capabilities regardless of file type or mode.

Has anyone ever considered making this conditional on the mode or
filetype? AFAICT, both are available at this call-site.

thanks,

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
