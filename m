Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A961C7EE26
	for <audit@archiver.kernel.org>; Tue, 23 May 2023 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjEWVHl (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 23 May 2023 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjEWVHl (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 23 May 2023 17:07:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC6FA
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:07:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba865ac594bso322116276.0
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684876059; x=1687468059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVP5LzI/ve6jH4tK/34zZWM+53m2j3w2mH0VmjtpPeA=;
        b=BfOSh5wSWWFyUGOELRl6BA8JloMrd9gWi6XndKWHrmOVB5kj5WEP34HTYQDJ9svaJl
         TCBbGCVgjgvMYBYMZRpiYR2GyoNTtlbh2ZI+2FYb+Us3BFX5qwLFUfBqzJ1uVw3HRgWv
         rsOAQWREV1qadXXmHnJIrlCZRJV2Wdg5RDl2tF4Nb6qtELTj0Z5noRMAIEhD6CoCRAzl
         SH1VMw49JC4YVgu6nut/Gz/9U8JH/90UEKQMV8GBQBSNy/sZ96uT6dxGr+KztfWC9kTn
         yw+N8XIxDkbtkOvC4ZkqNxhbH68wTiYNDOcyDUppC5EgSdSllj7ipLr1kudbcR0W6Fjr
         Bs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684876059; x=1687468059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVP5LzI/ve6jH4tK/34zZWM+53m2j3w2mH0VmjtpPeA=;
        b=GURYmK6cMWvL+0wUymCGznyrsfr/7mtBkRG6QTELGe++/VIKHy5FKfpD/nx8VefqXB
         dnb8HLNBQMkjhMyIRfZfDgkR1cJxEwWdGlhuAy06Lr+ed52XolXNw2DylP2nbeYqVMZz
         PwmNs4TSLCsFkJFvobpIm9asogRX4bHoydR/tY9awyPBmz+rv29YBjv7MYbwJ6KaB3QC
         z+6aq4xst+a1eM3mXJtdA/ceaKYMkhnM8auF/bF8LSAnKQwqRK/0E9Y9gELP5MbqH1HH
         rzjFLliTQdZ1g9hueBc7YAE5R6/aNNTuXnAveFcM5EJXD+CgCpCoo5WFUTYt8izxRrVC
         ci8A==
X-Gm-Message-State: AC+VfDyIE1RvYTB8RmvsfwrDrQL4cPvycB45IiW8PPrB3lJk4oSJe3v3
        QDdW1dFYnU8RBLh43613ZVJ3ZFnJ+BPbfpaVzypKht2t9KPFeJY=
X-Google-Smtp-Source: ACHHUZ5rK3Ve6yCeCDSShfAm6OgVIhvIZmYYhAR1Cqf2UEFL4h8UfkO54aX2mwgZ58gCQ2Lrv0I6QYLEffpa3imx3Rk=
X-Received: by 2002:a81:9206:0:b0:55a:2ce1:2353 with SMTP id
 j6-20020a819206000000b0055a2ce12353mr15770843ywg.2.1684876059326; Tue, 23 May
 2023 14:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
 <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com> <CB4B209E-8931-4FEC-A967-F3D50C0D7B1C@nutanix.com>
 <F900B719-7760-4E22-82A2-933ED775AA19@nutanix.com>
In-Reply-To: <F900B719-7760-4E22-82A2-933ED775AA19@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 17:07:28 -0400
Message-ID: <CAHC9VhQ73CcDtO7DAaRaN3aJiSBn_XQLAO83iGuGchky5hOvDg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] audit: do not use exclusive wait in audit_receive()
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, May 22, 2023 at 11:58=E2=80=AFPM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 22, 2023, at 13:44, Eiichi Tsukata <eiichi.tsukata@nutanix.com> =
wrote:
> >> On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
> >> On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >>>
> >>> kauditd thread issues wake_up() before it goes to sleep. The wake_up(=
)
> >>> call wakes up only one process as waiter side uses exclusive wait.
> >>> This can be problematic when there are multiple processes (one is in
> >>> audit_receive() and others are in audit_log_start()) waiting on
> >>> audit_backlog_wait queue.
> >>>
> >>> For example, if there are two processes waiting:
> >>>
> >>> Process (A): in audit_receive()
> >>> Process (B): in audit_log_start()
> >>>
> >>> And (A) is at the head of the wait queue. Then kauditd's wake_up() on=
ly
> >>> wakes up (A) leaving (B) as it is even if @audit_queue is drained. As=
 a
> >>> result, (B) can be blocked for up to backlog_wait_time.
> >>>
> >>> To prevent the issue, use non-exclusive wait in audit_receive() so th=
at
> >>> kauditd can wake up all waiters in audit_receive().
> >>>
> >>> Fixes: 8f110f530635 ("audit: ensure userspace is penalized the same a=
s the kernel when under pressure")
> >>> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >>> ---
> >>> kernel/audit.c | 17 +++++++++++------
> >>> 1 file changed, 11 insertions(+), 6 deletions(-)
> >>
> >> This was also discussed in the last patchset.
> >
> > This bug is much easily reproducible on real environments and can cause=
 problematic
> > user space failure like SSH connection timeout.
> > Let=E2=80=99s not keep the bug unfixed.
> > (Of course we=E2=80=99ve already carefully tuned audit related params a=
nd user space auditd config so that our product won=E2=80=99t hit backlog f=
ull.)

Good.  Resolving your issues through audit runtime configuration is
the proper solution to this.

> > BTW, the default backlog_wait_time is 60 * HZ which seems pretty large.
> > I=E2=80=99d appreciate if you could tell me the reason behind that valu=
e.

I do not recall the original logic behind that value.  It is likely
that the original value predated my maintenance of the audit
subsystem.

--=20
paul-moore.com
