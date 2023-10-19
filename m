Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE3DCDB465
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjJSOnD (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjJSOmx (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 19 Oct 2023 10:42:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF7D62
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 07:42:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a822f96aedso80457537b3.2
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697726557; x=1698331357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2dPQgM487dl8eK/Az1e2OpIFQy2ov7jxtex6lgh/Rg=;
        b=LQQaMPkaBORM/G+SdBTsfyy8cOJF8YPAYebOM2y7q4r9y9XZPGylQ4iFcQpG04QJi+
         h/A+nogWdRngajh8KV0JNLQKhl5FQgn7JF4hUj5oL8bPDfoJHJ9FiIIIQoQUrOTXMqDK
         Taf3+rptmZ3b6JqMwKo6UXbpLcKgmk8+ml9PY5YzmGjRD230LGzmB0llo5UJg7OTIgrD
         QLGqA72KwXpIleeySVR3ttQ7h/HqcKGe1hqd+7h1L2tTCsFbq7YwNOCmkhI0cavI92Iy
         JmRhoahb4lHUgQO9gyfN95wIerAKUZw1zJG5oW1tgZscvPBm/q3aEu3d3RiL/+vMd0Z2
         uQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726557; x=1698331357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2dPQgM487dl8eK/Az1e2OpIFQy2ov7jxtex6lgh/Rg=;
        b=YA2hCvZrDsZ9+KkicfI272ohwJCoFya4HYobIrKexbn3MXBY/7ehms2pNnqidp/DOp
         98sxgMvjHfQxSd+ZlGX8XWV+axYxGklq8k4W1rTBrrLyMdGTyoYWGU0E1mmCbEE6qa0k
         321RNvIBfnpMNYdZYn5LkOl/5UbKsUgEAsAJfG450ICrk/CiuUAnUAJdbq2d2/5cP+uK
         q0fDUryFgmqqnlG5HeeTvnsn35nV2zK0FzGndCy9+Xnqo3tv6oLldxH7EcYrqukf+BEh
         SL2ZOVIWHF6X7Q8KzoGuJs2be7bmZedy0L9Cq+u3VrkP+rxZgTAdGG9JlCXpMQTsle5R
         FKDQ==
X-Gm-Message-State: AOJu0YyVtoOtqBdirh1dnPOmUJwoFetEZ34INusnLsEdcf8jp0xKegfb
        2UMFnaf5d0y5/c/V8JMiwjaOh6mEfmmYATHRyRjl
X-Google-Smtp-Source: AGHT+IGVeam5t+50fiLFboW2IX8XuHf0oLvoBUcKiRRMBpzBFzlzbYK5WQVdgZBFn0TFC4vEemcDQVvw1mkdXZOhkjA=
X-Received: by 2002:a25:ce41:0:b0:d9a:634e:5ad3 with SMTP id
 x62-20020a25ce41000000b00d9a634e5ad3mr2696054ybe.13.1697726557198; Thu, 19
 Oct 2023 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com> <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
In-Reply-To: <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 19 Oct 2023 10:42:26 -0400
Message-ID: <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wed, Oct 18, 2023 at 10:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 18, 2023 at 8:22=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> >> On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> >> >> The get_task_exe_file() function locks the given task with task_loc=
k()
> >> >> which when used inside audit_exe_compare() can cause deadlocks on
> >> >> systems that generate audit records when the task_lock() is held.  =
As
> >> >> we should be able to safely access current->mm we can drop the call=
 to
> >> >> get_task_exe_file() and get a reference to current->mm directly whi=
ch
> >> >> we can then use in a call to get_mm_exe_file() without having to ta=
ke
> >> >> task_lock().
> >>
> >> I don't follow what's the deadlock.
> >>
> >> You mean they hold task lock for current and then call into
> >> audit_exe_compare which takes it again?
> >>
> >> I would argue any calls into the routine with *any* task already
> >> locked are fishy at best (I'm assuming there is an established task
> >> lock ordering which may be accidentally violated).
> >
> > A link to the original problem report is below, but the quick summary
> > is a capable() check in the do_prlimit() code path.
> >
> > https://lore.kernel.org/audit/668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@cano=
nical.com
>
> While get_task_exe_file working without taking the task lock would be
> nice, I think the *real* bug is do_prlimit calling into
> capabilities/security machinery with said lock held to begin with.

I'm not going to argue about do_prlimit() taking the task_lock(), I
can't say I've thought enough about that, but regardless of what
happens there I think we can fix things on the audit side as well.
Thinking about it a bit more this morning, I think we can safely
ignore the non-@current case in audit_exe_compare() as the whole point
of the audit exe filter is to record the actions of processes
instantiated from that executable file; if the @current task is not
being logged/filtered, we shouldn't have to worry about the exe
filter.

I'll send out a v2 of the patch later with those changes, but like I
said at the top, please don't let that stop you making improvements
elsewhere.

--=20
paul-moore.com
