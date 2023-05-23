Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C857C7EE26
	for <audit@archiver.kernel.org>; Tue, 23 May 2023 20:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbjEWUzw (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 23 May 2023 16:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjEWUzv (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 23 May 2023 16:55:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD03E42
        for <audit@vger.kernel.org>; Tue, 23 May 2023 13:55:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561c1ae21e7so2752557b3.0
        for <audit@vger.kernel.org>; Tue, 23 May 2023 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684875338; x=1687467338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN4E6iUtsQjZfLkF3i7CiEIofVPA2cKwz0ZGyJmE7mI=;
        b=Oc6M9rpHqYdNsnjsb4vqbdgybhIUckny+YVoj4ULygXeFeEzYDGgIWwysczYQUM3re
         eCTCD2P0+0H1xScFXIVmSaw2cCEeekZVwGjMLAT504yhvaHVVoIcIWscBRDKa0YWblzm
         aX4rHV6b0gPIwFbE+gNoXaKJzyi75jMrE3xmtlNaMnFPRKDb8Xt73sEPaiwpxVFQTjGm
         7cTQxlDLtaqfB1NS+AcgDiKXW5KNltjeHwsmr3E4u5fdQ+uReGL7bBvSF447kJot4TCa
         n/RN3HB9A9EnHTK20VYkqPXRauTzAKB5Za+8+6HIB+2Ts8Pf2hTTWeZ73KDJV7e4Ba+8
         bwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875338; x=1687467338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN4E6iUtsQjZfLkF3i7CiEIofVPA2cKwz0ZGyJmE7mI=;
        b=hgGJ59nMB5yzuOZK9BzHURNQDxseuhUnpQyUrP2hmBki6TgcVMvrxdtVGFotcMnZmd
         4ORwD9cXeZjkZwg8qkwJ/NkzpS66j9aLQAhxQyEO5L9YasjM/7QvpeCLptn3ccNACRUM
         H/3uFwbj2UDtEwdQBqVunTnJ610jh9B7y8e+S2UJ9BBtxhbe2y2ouZTtqr0E1K5tMJN2
         J4rSji53fANxF0zYwP+/Bf4DClGD8LDvS0yMosu67ml60smGe2MmHLI5o20O1Mq97BKW
         natXgWkrn6bdRagx+tFwEsMcU/SFITHg0ZsHM9D89/VdQXAjDdwhhK2E4OMQex4MV38W
         P0iA==
X-Gm-Message-State: AC+VfDwLt0GDwnJas8qOsrfgI+IO6oBYKNk7+2OYqxLst0SAiOuVHIhU
        bfQeQaTGk91ZKjY4xzhVMG/URF2R7J1rEicyAmK2
X-Google-Smtp-Source: ACHHUZ4t+Fcvuqxuoa8c0McC3FnrKB51DfRQlYW4AcY4FXRAkFix15al8EtqXrM/HOxrD/tx6jScSENxlCadfYtjl/M=
X-Received: by 2002:a0d:d9d3:0:b0:55a:98ff:f07e with SMTP id
 b202-20020a0dd9d3000000b0055a98fff07emr16474721ywe.16.1684875337916; Tue, 23
 May 2023 13:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
 <18aac53d73e41b33b71d9e5d0f5d4286.paul@paul-moore.com> <B407A72B-68D3-4FE8-B3E7-20B4DA3070C6@nutanix.com>
In-Reply-To: <B407A72B-68D3-4FE8-B3E7-20B4DA3070C6@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 16:55:26 -0400
Message-ID: <CAHC9VhR_CumgqoXYdso7z+tMvkbPHc8K4ygk66wHDheyG+bpRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] audit: account backlog waiting time in audit_receive()
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, May 22, 2023 at 12:22=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
> > On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >>
> >> Currently backlog waiting time in audit_receive() is not accounted as
> >> audit_backlog_wait_time_actual. Accounts it as well.
> >>
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> kernel/audit.c | 44 ++++++++++++++++++++++++++------------------
> >> 1 file changed, 26 insertions(+), 18 deletions(-)
> >
> > The audit_receive() wait is different from that in audit_log_start()
> > as processes calling into audit_receive() are performing an explicit
> > audit operation whereas those processes calling audit_log_start() are
> > likely doing something else, e.g. opening a file, that happens to
> > result in an audit record being generated.  The fact that the
> > audit_receive() accounting logic, as well as the timeout calculation
> > used, is different from audit_log_start() is intentional.
> >
>
> The intention still sounds a bit not clear to me as both cases wait using
> the same parameter =E2=80=9Cbacklog_wait_time=E2=80=9D and use the same w=
ait
> queue.
>
> IMHO, it will be better to have some comprehensive code comments there.

A fair point.  I'll add that to the todo list.

--=20
paul-moore.com
