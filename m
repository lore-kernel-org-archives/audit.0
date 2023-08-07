Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8667C001DB
	for <audit@archiver.kernel.org>; Mon,  7 Aug 2023 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHGSxy (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHGSxy (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 7 Aug 2023 14:53:54 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2E1722
        for <audit@vger.kernel.org>; Mon,  7 Aug 2023 11:53:52 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-586bacac98aso20791017b3.2
        for <audit@vger.kernel.org>; Mon, 07 Aug 2023 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691434431; x=1692039231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QQzTAj8Pbqv3+mVuh8/yIVIuCWrisEf9OKlYzxnFeI=;
        b=WAV7qSLv4IbtZI/iMfWM3t4KlDvnlSjvw5N7lirxJ51zM5kCDt8i6k/dwnCqEQEKr1
         Nst+piGU5iUPWD8zZ4OGWjPskb4mHV/OhwJq+CJsBASmylakW+bECOLNU6ThUN6BS7be
         sPEknVDL0/YUKcOPfj3hB+eKlEpMCDbg23+AIljlMFVmyoATWkKiYQ/TOeOqbisE7sHq
         L71QTh2LC7Tg60nE6eAJGqXz/sIfv5jabGc6eOA+olAdBp6q/wRaVWSmW1eSbR8W0bIp
         FK7HVJms/J5/XKT1hwGCbYMIm/ubxbLVhkiBvkw7fUQsJzij7XkV0iG0W1D03rM/QH2K
         iz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434431; x=1692039231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QQzTAj8Pbqv3+mVuh8/yIVIuCWrisEf9OKlYzxnFeI=;
        b=O9ZjMdVCXVdMKO+KH98Bu/S97AUD9nIyad+tRxXE8KR482qy7EvYYLD8O+QE1YSFqm
         B93Dz5DHPFO33DopOIDsIRO+eut4UVEsZZjzp0/fHJmeRFOQ7li5taH8XUAl972R7t/8
         R5wZ/KfdSN2c7n79WHnEpOQNcBKclCQPVjgYQSN5Q2CYZ9E+RT3J3owxeStCmPkbRxG0
         jFM/4bxqLjwFl7RSOEaRzpSxSL3VOoCPMUA5V8c2duLy+BCAyZnrsjPrHAcw1qjiQXlk
         YZ3m2z/5ARbw+lyU/rFogKp5fK8EvJNQRK6BrNcUOcuLb8uvGPAUqz8hWG1HmSEZaNQq
         TzUw==
X-Gm-Message-State: AOJu0YxrnZnHm8f+8D9OottMZROSn19wMobXk+6ksMH/CnV5fZ9Ip1d5
        514lVAGdXu2oROfIwjV42v68vMJNFT/FSVjX29aM
X-Google-Smtp-Source: AGHT+IG1afV8u+sL288doaRx2Pgb6JRTUIxE+TVIx9Qg3KBE/BALrEmVgJnZGdCOvBxsVgJpQQaf8dMjXUu4YT5ynyo=
X-Received: by 2002:a0d:fa44:0:b0:583:741c:5fe6 with SMTP id
 k65-20020a0dfa44000000b00583741c5fe6mr6661985ywf.52.1691434430935; Mon, 07
 Aug 2023 11:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
In-Reply-To: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 14:53:40 -0400
Message-ID: <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com>
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        audit@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Sun, Aug 6, 2023 at 9:05=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> When an unexpected system event occurs, the administrator may want to
> identify which application triggered the event. For example, unexpected
> process termination is still a real concern enough to write articles
> like https://access.redhat.com/solutions/165993 . TaskTracker is a
> trivial LSM module which emits TOMOYO-like information into the audit
> logs for better understanding of unexpected system events.

Help me understand why all of this information isn't already available
via some combination of Audit and TOMOYO, or simply audit itself?

In the case of an audit-only design you would likely need to do some
processing of the audit log to determine the full historical process
tree of the process being killed, but all of the information should be
there if you configure audit properly.  I'm less familiar with TOMOYO,
but your comment about this LSM recording "TOMOYO-like" information
makes me believe that TOMOYO already records this information.

--=20
paul-moore.com
