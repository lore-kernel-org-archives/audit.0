Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E7C41513
	for <audit@archiver.kernel.org>; Wed, 16 Aug 2023 13:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHPNiX (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245602AbjHPNiP (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 16 Aug 2023 09:38:15 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DC26A9
        for <audit@vger.kernel.org>; Wed, 16 Aug 2023 06:38:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58c7bd44c7bso7988097b3.0
        for <audit@vger.kernel.org>; Wed, 16 Aug 2023 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692193093; x=1692797893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFk6yRXIIHkOEvFC134UvLIF2wd6FFDonNio1jeok9w=;
        b=RHoKBPupeYA7SrWo0q7PbNF5ntazEJKGsU97Zf9M3m0BVAUoOeZVNvoLNIRLdUkWTi
         sFFdOMafEkwKwKrCksLSRBZTxNbDND5cXKFDyPFTFj/h6Qp3NBTzANx2nfJDFWN1jss/
         7V4Lupd7U7EihO51vO648AM8KsoYyUqjDwbqC2phWZGbtqAuwrZvOif2vuMsbbRIqBcz
         uufM3u+0BAxxqInkAKotUiO5mKy7MHoX57owZtFRsPgNWO1XF03eW79z0WUj96OhRajy
         mZAv37KcXxRGPG3DzkBYp2h1tXU8LpMcJQ6dgMq4d/1hfpVDEf2Lu1eS7RDSgGNcSejE
         GNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193093; x=1692797893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFk6yRXIIHkOEvFC134UvLIF2wd6FFDonNio1jeok9w=;
        b=PIQGVpspgmlK2XG9ggtS9K13mXac6cyt8OYcUC7jrVuw8bYxJ3CLPmk9LtmjYQSqkV
         rPWNZ3lPoIfC3LUvYF8kh9b1ukpW14mzYVmlyCiH6r7lorGnV/2mw9XewaUZ7w2CQBfF
         RwFFJD6oQxs3lc64PdurugdsGW3sH6I0Xqy4IDu9cWId3Qwj+dr2UkUDkRX+Az8fwHqS
         SiTacLA86Nbx8xy0tjstWskBZfK9LZuJvXY9MQSi2Y4u/PYk+WKhTiEfpgT1EeTJ2j4A
         NwKrJV8n++4vINUdY8rOBGbGI5qwtX5EGcY8ep7ObAs8mujvwReyfxt4DFzbx2Zhuz4o
         9nhA==
X-Gm-Message-State: AOJu0Yw7mioMBoL1MAwifDmo8uuSmZ8IhdPfy2AcqgMdDZabGNFw7puo
        duHT7YU4Vo1viVLtJT8sCeas+P+Q2rC0VXz/Pu9h
X-Google-Smtp-Source: AGHT+IGGDk9Pyi5oSqBh7ckQNXLO3AWM6VH2oSh9mxDFPuQuoWa1Tzd0Ad8SzA7VmXTVYyeihZMbBixnVbyBWmdOdNA=
X-Received: by 2002:a81:8404:0:b0:58c:5132:deee with SMTP id
 u4-20020a818404000000b0058c5132deeemr1713911ywf.43.1692193093583; Wed, 16 Aug
 2023 06:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230815204553.52261-1-atulpant.linux@gmail.com>
 <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com> <20230816025550.GD57274@atom0118>
In-Reply-To: <20230816025550.GD57274@atom0118>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Aug 2023 09:38:02 -0400
Message-ID: <CAHC9VhQc9jfE=H-3ePTBbEQ3nGj8z1cwGPaZebrn=YjqO+J-+g@mail.gmail.com>
Subject: Re: [PATCH v1] kernel: Add space before parenthesis and around '=',
 "==" and '<'
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, Aug 15, 2023 at 10:55=E2=80=AFPM Atul Kumar Pant
<atulpant.linux@gmail.com> wrote:
> On Tue, Aug 15, 2023 at 06:09:19PM -0400, Paul Moore wrote:
> > On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> > >
> > > Fixes following checkpatch.pl issue:
> > > ERROR: space required before the open parenthesis '('
> > > ERROR: spaces required around that '=3D'
> > > ERROR: spaces required around that '<'
> > > ERROR: spaces required around that '=3D=3D'
> > >
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  kernel/acct.c        |  2 +-
> > >  kernel/auditfilter.c | 16 ++++++++--------
> > >  kernel/auditsc.c     |  2 +-
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > I changed the subject line to "audit: add space before parenthesis and
> > around '=3D', "=3D=3D", and '<'" as the "audit:" prefix is more appropr=
iate
> > and I'm a believer of the Oxford Comma.  Otherwise it looks fine and I
> > just merged it into audit/next, thanks.
>
>         Thank you for your comments. Do I need to change commit message n=
ow?

No, I fixed it up and merged the patch, it's just something to
remember for future patch submissions.  Here is the commit in the
audit/next branch:

   commit 62acadda115a94bffd1f6b36acbb67e3f04811be
   Author: Atul Kumar Pant <atulpant.linux@gmail.com>
   Date:   Wed Aug 16 02:15:53 2023 +0530

   audit: add space before parenthesis and around '=3D', "=3D=3D", and '<'

   Fixes following checkpatch.pl issue:
   ERROR: space required before the open parenthesis '('
   ERROR: spaces required around that '=3D'
   ERROR: spaces required around that '<'
   ERROR: spaces required around that '=3D=3D'

   Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
   [PM: subject line tweaks]
   Signed-off-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
