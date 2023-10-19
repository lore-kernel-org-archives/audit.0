Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1EDCDB483
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbjJSQ4D (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbjJSQ4C (ORCPT
        <rfc822;audit@vger.kernel.org>); Thu, 19 Oct 2023 12:56:02 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB83181
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 09:56:00 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4a25f6390so5337617a34.2
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697734560; x=1698339360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3lW1v70J7PdR/I17j0E3NUMpHYTGpCQs1xOcREBJ4c=;
        b=bBlTWzkj98wwQ//dDK6h4+tzckqlba1PZtcIMB9e0ovT9tR55a3pMY4Hoztlr2oyNV
         mphMjN5E4fhyypWhobEHZUPeKIssHHW/IOjVQYN68Pg9zcgwxYccRMGYyW6ZlAAzTBoU
         MVhBZG8eR7TAzVU2D07UYABhncgezK6tB+EnaJN8oV0Q+eJ+xk+3YHiQbQNkm01yAAHa
         9eCOVKpZJmZ651uYmPsjdPmTW2zQ434ENaYS38Te/K3Ky8y6RjaRqS0E5MIuLLltXb0B
         5FN1DqyF+FG3xRWLqvFEdphCY/fEX2kscQXNxEmkKKfczwvBl0OgQ02ZIq/j3+77TdpT
         GvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697734560; x=1698339360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3lW1v70J7PdR/I17j0E3NUMpHYTGpCQs1xOcREBJ4c=;
        b=atfifXp305E05EJxcThRlKbceXPXXZ8g0Pi/1jPmtAH7j4QlQesEB+VoBO0mAz+BrQ
         5Oz0I/NHZWIlokez0mpQbTngV1dr0IIfazJmpl70DmV4dcmRj3F9KRPsx6nD+tvX9Zmt
         KuL09ktZruqbBQGr6fk4MKWwUIfO739VwK1NuabdmNEmlHqbVZ84C0+EkxeqTJy3IF4d
         QUlZ3oy0F3ivRVLecH/1S8w3junXjgwEIcNOfRr1maZfHyv/l4Tma37vH3s2AyJSh7KM
         mLCqgbSJkSv7ulQ6UqqDFaXjlJPVo2tjBaoiuqKnLv/Y6GaPVYNVvGta684NECvWYVd7
         4Hfg==
X-Gm-Message-State: AOJu0YzX7gpVf+4gZDA3K1ZZao56nNP7xhrOedQY1bTzkrPsaWiLo98m
        iYb79Okqtl/qJVwzkdlDSDTPhtWU8Qr6e2BujFo=
X-Google-Smtp-Source: AGHT+IGHbAr3Vh0pZXN+KlsAtt4APyXrYJ/yWcU9ABSPscAwKb5CVCLtgIChdPKGQIrudFBS/xl48kSp2yDhOYFhLN8=
X-Received: by 2002:a9d:6858:0:b0:6c0:9498:7a77 with SMTP id
 c24-20020a9d6858000000b006c094987a77mr3016297oto.32.1697734559992; Thu, 19
 Oct 2023 09:55:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Thu, 19 Oct 2023
 09:55:59 -0700 (PDT)
In-Reply-To: <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
 <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
 <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com> <CAHC9VhQDE43vwe2UAQCYeXuAQcdOj-evsie=spit-oXcekwNkw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 19 Oct 2023 18:55:59 +0200
Message-ID: <CAGudoHH5R_zNf0uLPSB+_o0N8bU2g29L6Nrz8Yo-KhG2Vot_ew@mail.gmail.com>
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
> On Thu, Oct 19, 2023 at 10:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> > Thinking about it a bit more this morning, I think we can safely
>> > ignore the non-@current case in audit_exe_compare() as the whole point
>> > of the audit exe filter is to record the actions of processes
>> > instantiated from that executable file; if the @current task is not
>> > being logged/filtered, we shouldn't have to worry about the exe
>> > filter.
>>
>> I did a quick stab at figuring out whether one can get there with
>> non-current to begin with, but did not convince myself it is not
>> possible.
>>
>> That said, should you repost, I think refing and unrefing mm should be a
>> voided.
>
> We have to deref current->mm to get the exe_file, but so long as we
> get a reference with mmget()/mmput() it should be safe, no?
>

For task =3D=3D current the very condition which allows you to safely
mmget also makes the operation redundant -- current already has a ref
on mm for as long as it executes.

>> The bug showed up with 18c91bb2d87268d23868bf13508f5bc9cf04e89a
>> ("prlimit: do not grab the tasklist_lock") which converted that lock
>> to task_lock. So I don't think pointing at my patch as "Fixes" is
>> accurate, but I'm not going to insist. ;)
>
> Hmm, 18c91bb2d872 doesn't look like it adds a call to task_lock(), did
> you copy-n-past the wrong commit or am I missing something?  From what
> I can see, the task_lock() was first introduced back in 2009 with
> 86f162f4c75c ("rlimits: do security check under task_lock").
>

Huh. That's some brainfarting by me, indeed with this in place it is
my commit which regresses.

--=20
Mateusz Guzik <mjguzik gmail.com>
