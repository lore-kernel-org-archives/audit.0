Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B7CDB47E
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 02:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJSCOc (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjJSCOb (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 22:14:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1433119
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 19:14:29 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b5f0d658dso4367835eaf.0
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697681669; x=1698286469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj6ZRs03RmhUwigjqoeNgW/zRJY6GkK57C40hoV9HcI=;
        b=FaonobGouV+lMd7iWCAJqTPj4El5hC7IZAcFp/ir+sa6dA0ny4FM+syBFxEUqDRTF9
         Nemc8J80khr+mqq6ONKzVUwyvSILj0jLS/FrGdrbSaP70irvXjca6gAkdw6UgbdUIWTL
         aP/nFnomrAoH10gYmPdJB8ksjP3N8BRs9uqhKCdVIlVP28LBSAQkh8S4wH1tlmn9h+UG
         bFattAYlhAWVMOtPSNbc5H14zEUH1/FycQcUuKYZA9IIzCsIrc+lnyPsAhOYpWd851P3
         Jr/IhwFgK6FtFM7Ek8nzac6mLC2zGJYYOu/CRlNBrRH2wc1tswlD+GrLQoCPQIcfwpUl
         9UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697681669; x=1698286469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hj6ZRs03RmhUwigjqoeNgW/zRJY6GkK57C40hoV9HcI=;
        b=gbkU783twOxVgpW1eZ7fvOalRBQcOd7YUtMwGqGwFsyw+m4cNUIMU77CWiVbG01bAE
         3LcyDxUuaX2S6alwo8jXor8tMcPyI3g9DXVKLPVwA9dlAAif1NqYDTuSmFCL2ChLypT3
         gjh46FRKxM2kZQ7QPZGsTjHIPJ63gVI68fyRSFQcIjKFhOCDLmZmEBN1eGbe017oO61R
         bEbYqRTQ0wNZCJ4dQmfZC7QskKp0rHu6PIZhvGSlZOSn7mM0m761biSkhvigCCwrhYVk
         D7AwhOCNPeVOHJpLWkL7ReNVJD+vgKoAo53Ya7eFTqqDzy8Hbfr7jWrOs43ebh/iNewN
         KP7Q==
X-Gm-Message-State: AOJu0YwOgIeEL0j6Eu3miMgGpUg4JPu2Xagp6w8ruZZeDxtcXpepN1zQ
        jvbRkPAp2hYpy4h3dutDylxIH0yqKEF6Qsskg2g=
X-Google-Smtp-Source: AGHT+IGD3qbVbu9efbkAxVBdT8OJddZU1R4lpSuhVIsMkN/qISBBRKbCLvpde3Xr993Jso1dadjrwI/lXWBcmzyolLs=
X-Received: by 2002:a4a:b441:0:b0:581:ea96:f7f3 with SMTP id
 h1-20020a4ab441000000b00581ea96f7f3mr975551ooo.7.1697681668944; Wed, 18 Oct
 2023 19:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Wed, 18 Oct 2023
 19:14:28 -0700 (PDT)
In-Reply-To: <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com> <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 19 Oct 2023 04:14:28 +0200
Message-ID: <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
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
> On Wed, Oct 18, 2023 at 8:22=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> >> The get_task_exe_file() function locks the given task with task_lock(=
)
>> >> which when used inside audit_exe_compare() can cause deadlocks on
>> >> systems that generate audit records when the task_lock() is held.  As
>> >> we should be able to safely access current->mm we can drop the call t=
o
>> >> get_task_exe_file() and get a reference to current->mm directly which
>> >> we can then use in a call to get_mm_exe_file() without having to take
>> >> task_lock().
>>
>> I don't follow what's the deadlock.
>>
>> You mean they hold task lock for current and then call into
>> audit_exe_compare which takes it again?
>>
>> I would argue any calls into the routine with *any* task already
>> locked are fishy at best (I'm assuming there is an established task
>> lock ordering which may be accidentally violated).
>
> A link to the original problem report is below, but the quick summary
> is a capable() check in the do_prlimit() code path.
>
> https://lore.kernel.org/audit/668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canoni=
cal.com
>

While get_task_exe_file working without taking the task lock would be
nice, I think the *real* bug is do_prlimit calling into
capabilities/security machinery with said lock held to begin with.

Taking 2 task locks taken in an arbitrary order sounds incredibly
dodgy and is probably already illegal. Even with the proposed patch it
would happen with do_prlimit invoked by non-group leader.

With that assumption, if one tries to argue that calling into
capabilities() and security_* hooks with a task lock is legal, then
none of the code inside can take the lock, which sounds like an
unsustainable limitation (even if it so happens that audit calling
into get_task_exe_file is the only case at the moment).

All that said I think the cleanest way forward is to add a dedicated
spinlock for rlimits and stuff it into signal_struct. I'm going to
hack it up tomorrow, but some more people will need to be added to the
discussion.

--=20
Mateusz Guzik <mjguzik gmail.com>
