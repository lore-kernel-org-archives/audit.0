Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69242CDB47E
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 02:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJSCSI (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjJSCSH (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 22:18:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C5115
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 19:18:04 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2e07e5f3aso177914b6e.0
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697681884; x=1698286684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7DgdBG65yrEyB8j71u6R+AIlf7qCP2x5JSEVYgfWhU=;
        b=MnWspybi00b6y93k8baWq2r0Z3VWszx35VUVG/OJWPYUOu0X858p7iSaA5LwsDvrtM
         qGQLSLDUp3Kc4n0aAiGNuSGx8ni4TyDP3n73j5hPXrq1Nfqv6H4qGhtYWnp7RMw0FwNq
         qDtkH97MVNHp+U/NJrA3fmboj73CjojqnQCPD0aUMl8pDnw1Y/cIAWgDp8/MPO+/gz7R
         lVj9/JuKpD7wV2Z8JFwhcpjERYNnwhuNdIujGkDAT9T48++qxDLxpr1B3mS8dtDkp+NW
         QvHS0AuwdVHYTD1y39vXef45QQlhJghU4vrUhda3omiv0S1We7AtRGpHvAvIxVlUEzMn
         oaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697681884; x=1698286684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7DgdBG65yrEyB8j71u6R+AIlf7qCP2x5JSEVYgfWhU=;
        b=sju/Vj5x9Sui4Qg0wGvkG0aqJ9B0gPtWoKwxDHXoZ7k+mzJfG5/V8g0qGM0tRq9zqw
         0lWTKx85XfO3M6hcvUHxbbWGg9CxbaqR38g7oB7KTZ+hjKMWe5NfWsf6CLRrL2dqMFmE
         kfPblPqacN7gFzUkZfJLFKs0plv3qhg1R4qe3rORKWe3cKnbGTXJZpEsymTYdspHVwTb
         AXeA25qoI88FYJjR9gIA7QFXbi2XeGi3J4JunY++KP0ePA6MCvT+G3tMxjjDreSxt+N5
         Joz0pyiSvQvVfp7mf6zDHkpRHGhgH9vdLcIe/rwrXEkQEBz8I2DR3QJkG3T+FxW/NAU5
         2/WQ==
X-Gm-Message-State: AOJu0Yz862NlvwQZ8fuLi+lTLgfWwZCquCrkGoYJnATXUgYsmwVRLO5K
        TMjR31ehnv3xRBhuf0DGl6CLYUj8kN93WN+GTP4=
X-Google-Smtp-Source: AGHT+IHcl6m8iVOBb/RuJkgrkEFyguLYuyfoYRnQANKIrmv8jkQMSuR8rkQHugkuEFxdTvRAWR/FK6JSVPQLXrfB3Es=
X-Received: by 2002:a05:6808:16a9:b0:3af:6ce3:ff0b with SMTP id
 bb41-20020a05680816a900b003af6ce3ff0bmr340110oib.19.1697681884003; Wed, 18
 Oct 2023 19:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Wed, 18 Oct 2023
 19:18:03 -0700 (PDT)
In-Reply-To: <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com> <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 19 Oct 2023 04:18:03 +0200
Message-ID: <CAGudoHF2cM=58T=E7Xf_=jedQmXLwCUAhLrhM_mXjqNru4Jt6g@mail.gmail.com>
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

On 10/19/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Oct 18, 2023 at 8:22=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>>> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>>> >> The get_task_exe_file() function locks the given task with
>>> >> task_lock()
>>> >> which when used inside audit_exe_compare() can cause deadlocks on
>>> >> systems that generate audit records when the task_lock() is held.  A=
s
>>> >> we should be able to safely access current->mm we can drop the call
>>> >> to
>>> >> get_task_exe_file() and get a reference to current->mm directly whic=
h
>>> >> we can then use in a call to get_mm_exe_file() without having to tak=
e
>>> >> task_lock().
>>>
>>> I don't follow what's the deadlock.
>>>
>>> You mean they hold task lock for current and then call into
>>> audit_exe_compare which takes it again?
>>>
>>> I would argue any calls into the routine with *any* task already
>>> locked are fishy at best (I'm assuming there is an established task
>>> lock ordering which may be accidentally violated).
>>
>> A link to the original problem report is below, but the quick summary
>> is a capable() check in the do_prlimit() code path.
>>
>> https://lore.kernel.org/audit/668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canon=
ical.com
>>
>
> While get_task_exe_file working without taking the task lock would be
> nice, I think the *real* bug is do_prlimit calling into
> capabilities/security machinery with said lock held to begin with.
>
> Taking 2 task locks taken in an arbitrary order sounds incredibly
> dodgy and is probably already illegal. Even with the proposed patch it
> would happen with do_prlimit invoked by non-group leader.
>
> With that assumption, if one tries to argue that calling into
> capabilities() and security_* hooks with a task lock is legal, then
> none of the code inside can take the lock, which sounds like an
> unsustainable limitation (even if it so happens that audit calling
> into get_task_exe_file is the only case at the moment).
>
> All that said I think the cleanest way forward is to add a dedicated
> spinlock for rlimits and stuff it into signal_struct. I'm going to
> hack it up tomorrow, but some more people will need to be added to the
> discussion.
>

sigh, now that I wrote I remembered prlimit operates on arbitrary
threads to begin with.

I'm going to have to sleep on it.

--=20
Mateusz Guzik <mjguzik gmail.com>
