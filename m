Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D86C001E0
	for <audit@archiver.kernel.org>; Sat, 21 Oct 2023 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUNv6 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Sat, 21 Oct 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjJUNvr (ORCPT <rfc822;audit@vger.kernel.org>);
        Sat, 21 Oct 2023 09:51:47 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4D13E
        for <audit@vger.kernel.org>; Sat, 21 Oct 2023 06:51:45 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-581d4f9a2c5so1104455eaf.0
        for <audit@vger.kernel.org>; Sat, 21 Oct 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697896304; x=1698501104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ6J72gL16c/Y2oA1uut6bW3Ixeb5uk8mwFPrLOpVYg=;
        b=HRt1IuHbn7tRZ84PtY8ddpjC6YM8kpGwBHDd051IrMVH8PTbqi0S+thXfY3ci/299x
         egW/I1l1FKcwDlnQieFkK1nRmniFYSuQJ7nH2rX9B0D5EeGIQei60L1IZkjRAc6V6B+j
         BUob3hA1fBy6aZGuJulCAzloR6geAYhNG0e0kGrh+YqahiEcAZ7ltlIYT0Bsjp90yDmU
         gLuQieaNsfuRwJE3lsfgSLEUagYLTRfPSe3/1ZzA31Wc5H6Fcv+jy3IghRPhBHSGzS41
         KuL38qsJZvf0vgJPlAS78xKPryekFLws4LJz4tQLCRXdwjEtprnF8RHpoXasTJiI4H90
         psSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697896304; x=1698501104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ6J72gL16c/Y2oA1uut6bW3Ixeb5uk8mwFPrLOpVYg=;
        b=OR4BpFGYyUWcaRhYnooJvrTO21Pr5TPz0N2+XhOdGLy/ZAC02iyJv3aY7AkRVkvXBl
         MXTZFEpYM9tenNyiVrmUS8+2RKAtEQ3AOUoyI3gbuzYvcbHlsM+veuEL69hjJy7U6zxw
         96OcBajjeTMBtunUl5mZ3IVFN0KOdkqTGFar+IlYuY97aMbCe7kpUDAEF6egAQiGexb1
         uSWwW0lNdILau82P0nmhOPzmph5seo48Y9s3y5iNxGCo6gLtqXPfJ+FvxUMp72T2aa8O
         99LS3N/QsskDIOtNMqFBUyHZVMCngdjz6YzxKGqlb9lifpGjeWpxXg2wJDT65n/h4qNC
         ECXw==
X-Gm-Message-State: AOJu0YwwvgEy/DaT4Zg87o1ir30zOczLpXGv08qSdnzaLQjb2+ATAz8V
        abZzKF2nBxTFF8YE5NfFVr6UOqQUWPIsWs4Ury+/QMzP
X-Google-Smtp-Source: AGHT+IGAaBLg+hC9xFbOEuFbtEqWuagvUImng4XiAlhkrW8K2RJvUzjcaMk5tZnPJ0dRJpmc7H3bHWSfogF/5sSGDPM=
X-Received: by 2002:a4a:e6cb:0:b0:573:4da2:4427 with SMTP id
 v11-20020a4ae6cb000000b005734da24427mr4434742oot.7.1697896304547; Sat, 21 Oct
 2023 06:51:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Sat, 21 Oct 2023
 06:51:43 -0700 (PDT)
In-Reply-To: <CAHC9VhQy6w6=ndC-8nY+tjM_A3bfGFoeDqViaxeFokH0FF4XdQ@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
 <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
 <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
 <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com>
 <CAGudoHH5R_zNf0uLPSB+_o0N8bU2g29L6Nrz8Yo-KhG2Vot_ew@mail.gmail.com> <CAHC9VhQy6w6=ndC-8nY+tjM_A3bfGFoeDqViaxeFokH0FF4XdQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 21 Oct 2023 15:51:43 +0200
Message-ID: <CAGudoHHwH1nJzQfS1OynoKmp--58CtiVB+BX9j46K6hwYxvJeA@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Oct 19, 2023 at 12:56=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> > On Thu, Oct 19, 2023 at 10:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.=
com>
>> > wrote:
>> >> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> >> > Thinking about it a bit more this morning, I think we can safely
>> >> > ignore the non-@current case in audit_exe_compare() as the whole
>> >> > point
>> >> > of the audit exe filter is to record the actions of processes
>> >> > instantiated from that executable file; if the @current task is not
>> >> > being logged/filtered, we shouldn't have to worry about the exe
>> >> > filter.
>> >>
>> >> I did a quick stab at figuring out whether one can get there with
>> >> non-current to begin with, but did not convince myself it is not
>> >> possible.
>> >>
>> >> That said, should you repost, I think refing and unrefing mm should b=
e
>> >> a
>> >> voided.
>> >
>> > We have to deref current->mm to get the exe_file, but so long as we
>> > get a reference with mmget()/mmput() it should be safe, no?
>>
>> For task =3D=3D current the very condition which allows you to safely
>> mmget also makes the operation redundant -- current already has a ref
>> on mm for as long as it executes.
>
> I've been using the move_pages(2) syscall code as an example and in
> the find_mm_struct() function the code either does a mmget() if
> accessing current->mm or a get_task_mm() if accessing an arbitrary
> task.
>
>   -> SYSCALL_DEFINE6(move_pages, ...)
>     -> kernel_move_pages(...)
>       -> find_mm_struct(...)
>
> What am I missing?
>

To my reading they did not want to special-case it in the caller --
they just mmput regardless of what task is.

Again, you may notice there are no locks held in that usecase. The
pointer is blindly derefed and a refcount bumped. For this to be safe,
it has to be guaranteed > 0 already, which it is for a task accessing
it's own mm struct. You can find the releasing mmput in exit ->
do_exit -> exit_mm callchain.

--=20
Mateusz Guzik <mjguzik gmail.com>
