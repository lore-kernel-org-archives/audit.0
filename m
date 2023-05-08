Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DBC77B73
	for <audit@archiver.kernel.org>; Mon,  8 May 2023 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjEHOHp (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 8 May 2023 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjEHOHo (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 8 May 2023 10:07:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8332137
        for <audit@vger.kernel.org>; Mon,  8 May 2023 07:07:42 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9ddcf0afb3so6147816276.3
        for <audit@vger.kernel.org>; Mon, 08 May 2023 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683554862; x=1686146862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgVHCFStHyFEBua8u8RV+JutzwXscYmBK+K5ZhkR0Mg=;
        b=PbULIDq1r/R8xzTzJBFlFWF81o69tIXLucUB5+mzHubffRz3cwwKrq0f7yFqXZqvuE
         qMvEwuQF8UlLfgQyy9k3DDFRql4u0qX9/9hc4ZAuIrfRhCt3SVcmOz7Y5NA5OoShF7Q9
         CyqVg0y+7ei4cV9BaxRj+drCTeEsGWan1EkrDc2UjCCAFLQnOLlLgmcV5jLTkYFZ5ypX
         DgVkPRueuvPSq08S6+knDgI2ZMYLJJJSAipHv5vuh284RTnGDUhi9t9sWH//EnpX4TNy
         taf6Ul2tkQ1TDE7bAoZCc0wQTvsjIUU4DE1SXnwDoXrN+wuCviPlTrsU8uYbZdcYooJI
         kvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554862; x=1686146862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgVHCFStHyFEBua8u8RV+JutzwXscYmBK+K5ZhkR0Mg=;
        b=CKAlOTDgHWc4uhzOQx9pVgvGcA3OKRlI5GNU6/y033DPJLEHkss1Oe9C3nQolETeh7
         IyoC5hA+ETOugZ6fr/SKF9PqIgsHRlM+bmRMze+mnKGmsHWBVMAg+lvIacCFZdxslQBW
         9dnhndZ1NWosJgB0yleEZLG/buId7c255EUdz1GN6+GlmI6YNTmuKsRmsgmq9sdHAiEm
         nO0o1G1pawk5iMXNpc+TTMj5Gc3NjyEQp1JuyM/F6Pb+rzoG/zg8lK63dSZvoRwMLMBw
         Iq6K7MbTErwxigSp5kA+fflfO8pG1lpMiMNNkk8KcDPN188Jq+ihfzT0Sg4GTB/tIPfB
         tpyg==
X-Gm-Message-State: AC+VfDzrwXGmWB/ZBj2K9YjYaNemBFJHWgcgeN53wr7dti0UXCC3E1mJ
        57KVKhpd61rX8iwvQ8eIPzEmCZD0MSyG+mQCaBnI
X-Google-Smtp-Source: ACHHUZ6V++KSSUvl4K6IQwPoruimFGL/Xm+HesWDr84R2ZNIkK7ng8HNkN6othl1VMr0bmiQQQknWZ7Qc1RCvae+6Yk=
X-Received: by 2002:a25:b11f:0:b0:b9d:7d55:8b93 with SMTP id
 g31-20020a25b11f000000b00b9d7d558b93mr12128303ybj.40.1683554861781; Mon, 08
 May 2023 07:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 10:07:31 -0400
Message-ID: <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com>
Subject: Re: [PATCH 0/4] audit: refactor and fix for potential deadlock
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Mon, May 8, 2023 at 3:58=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> Commit 7ffb8e317bae ("audit: we don't need to
> __set_current_state(TASK_RUNNING)") accidentally moved queue full check
> before add_wait_queue_exclusive() which introduced the following race:
>
>     CPU1                           CPU2
>   =3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=3D=3D=3D=3D
>   (in audit_log_start())         (in kauditd_thread())
>
>   queue is full
>                                  wake_up(&audit_backlog_wait)
>                                  wait_event_freezable()
>   add_wait_queue_exclusive()
>   ...
>   schedule_timeout()
>
> Once this happens, both audit_log_start() and kauditd_thread() can cause
> deadlock for up to backlog_wait_time waiting for each other. To prevent
> the race, this patch adds queue full check after
> prepare_to_wait_exclusive().

Have you seen this occur in practice?  The first thing that
audit_log_start() does when detecting that @audit_queue is full is to
wake kauditd_thread, which should start immediately draining
@audit_queue (even if a daemon is not listening, the @audit_queue will
be drained into one of the other queues).  While it is hard to predict
scheduling behavior, it seems unlikely that kauditd_thread would be
able to process the entire queue before audit_log_start() progresses
from waking kauditd_thread() to sleeping.

In the absolute worst case, the task attempting to emit an audit
record sleeps for either the configured wait time or until it is
awakened by kauditd_thread() which could be triggered by another task
attempting to emit an audit record.

--=20
paul-moore.com
