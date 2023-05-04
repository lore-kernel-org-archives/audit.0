Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C591C7EE21
	for <audit@archiver.kernel.org>; Thu,  4 May 2023 18:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEDSlB (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 4 May 2023 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDSlA (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 4 May 2023 14:41:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248914EC4
        for <audit@vger.kernel.org>; Thu,  4 May 2023 11:41:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so10394859276.0
        for <audit@vger.kernel.org>; Thu, 04 May 2023 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683225659; x=1685817659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9xdhwUAnQWSOiwrZeQw6aoX3Gy+eNLBtGfDo4KMXaY=;
        b=UXAe9KdrZ7eoV7ImMs/SOInOyFXoNdtv+51tg4zSORs8ykuFvJ7pZKwbjihP9zZp9X
         tEIaUWt3r/7ypdZbjBdSYqvdHg8J8CzbVaNfXqXAbPn1U3TyoSuNUXN92ljkPzb+dxoA
         vjFa+Yk4Cy6OcnseU1qE3vdpoIVayJUNOJ7K4I4FMNmB/nOWyTi493P4UM76R0TP9nGt
         QE6MkJ3D7UP3byGv75Xr10uzj8IpP35KTuM309wrdlRRLeX91LGMTwgiwI+zMHDehgUK
         Ci0UDhMZe4w6+zMl5Ln3KmMdi+pojEeubNDJGEhocPu5EF8fjYXTl7wuAoz+SxOEMpk1
         Bc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225659; x=1685817659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9xdhwUAnQWSOiwrZeQw6aoX3Gy+eNLBtGfDo4KMXaY=;
        b=Fi5bA/h9RHkZ6IW0Jz5mvoEhSbk29g1w8BbOGL8wany3MC1NACw33CLfP//SK7WLIt
         uFltLvtVPYnIVX6MbkCztFj/cIesXYwoHk99ekba1Yud3a5EkD8CV3dSJZWbxejIpg6i
         UQqrafrsZ4dw8pgT0dK/Bfin0SQf8K0/ry0Ma06yFRRiOnYmmpf2/3HyolKDtOzdTd0a
         BCSCWFg/IcBU2gZ+27zxGBGv4XJBaLOaaj/95L7x7fzkpiTho5NQihjPFSOIIwshy+Ga
         aRhEyQy0PGU6s8oINrdYK+ZawTsvMtUDPLK2A/RjZp/8qy8aTx1QEsylocsMIH9cW5tn
         duTw==
X-Gm-Message-State: AC+VfDwB0OUy1TigbbW0DVXF+/DKN4Tn4zni/4KGSmwqEYWFyL4scCU3
        PguzrNrRem27ymX3FPA2LeC612mZySm3NtU+9xtl
X-Google-Smtp-Source: ACHHUZ580oimtnPGGVNllOaIowynCQqC408i0OYmqbn0PN9cueyS7S+NjBcjgqJJZQDVIzbHB6SByrwfsP+907qqOvg=
X-Received: by 2002:a81:1445:0:b0:55d:6a47:f3e1 with SMTP id
 66-20020a811445000000b0055d6a47f3e1mr3146303ywu.17.1683225659305; Thu, 04 May
 2023 11:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com> <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
In-Reply-To: <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 May 2023 14:40:48 -0400
Message-ID: <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rinat Gadelshin <rgadelsh@gmail.com>, audit@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, May 3, 2023 at 10:50=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/05/04 7:12, Rinat Gadelshin wrote:
> > On 04.05.2023 00:27, Paul Moore wrote:
> >> Can you be more specific about the kernel threads you are seeing, are
> >> you seeing multiple "kauditd" threads?
> >>
> >> % ps -fC kauditd
> >> UID          PID    PPID  C STIME TTY          TIME CMD
> >> root          89       2  0 Apr28 ?        00:00:00 [kauditd]
>
> I don't think so.
>
> kernel audit subsystem uses kthread_run() in order to run short-lived ker=
nel threads.

Thanks Tetsuo, I agree that's far more likely.  Ever since I took over
shepherding the audit code, all of the thread issues have been around
the main audit queue thread so it's a bit reflexive to assume that is
the case :)

--=20
paul-moore.com
