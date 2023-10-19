Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8BCDB482
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 14:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjJSOxB (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbjJSOxA (ORCPT
        <rfc822;audit@vger.kernel.org>); Thu, 19 Oct 2023 10:53:00 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749B114
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 07:52:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b9231e91dso4749199eaf.2
        for <audit@vger.kernel.org>; Thu, 19 Oct 2023 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727178; x=1698331978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yoguu+SHJrUJ5qungOTBwMYEgDToCYEKjhmSvzyaqsI=;
        b=QjCUzqrQYzEXdf8iy3DzA8eT2Ns0lFG9u3mwAf/GxzIXsnJcmlMbPEab2HmMMvH3FQ
         2ACVe0azKYgJ7Zq5hoVKI8eNhsJmrD6D+W2TuBTPm4QAKCKlfLBRqF0yunU3mc6VF0XU
         v5+qJyOOCxC3X0kpSwlKtd9ah6fIwjDg6Djp664TcA5GbhtzUEpVXT+/wgHvgpe/4p61
         Uz7+KlPQZLhGt8aixGmrerEOytJoxXvBU4jBkH9PjDtLM9ccxVGBp8A1ucrpfHt0HJW/
         TTu/MR/YduRhlci4Zrl+kIN5/aCNM44r7o6qFezBcMDegy0AezMInDA3hhbfIF1QJg3d
         vRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727178; x=1698331978;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yoguu+SHJrUJ5qungOTBwMYEgDToCYEKjhmSvzyaqsI=;
        b=WizlmzPy1IwvBx387dd7Oeqp8DHasxajsutQtmp3hdX3BdE6Y1pXqcdEnbWvbPAeRO
         pijFGAKrXD2Y20xWql4fV/q5owkqmVfPWrpGFDF+hqyVwnC8PmrzYN7c6Js/b566hGMB
         yuOCMzMrDV3vS7fYXBYdOEjuCmrNiBV26UgoY6G1F1tOEZ9ETnwsn/Wdc2r1XBCe2YUB
         QOnkdrfWhuyDsjJ37JZSCGNxAqPzPsvKJV45kfj7lCeFOTv5qok3LFQV2mBjM4GVvCUg
         G3bynsZPHlKYcBbwapa/r2SuMMmriLffdesPoa313Ahz4NcwjMiZHaN/gNXS+EfIYRga
         H0yg==
X-Gm-Message-State: AOJu0YwJgDk46hrqxrR/s8T+icfI4spQmyVFsfRB/DMXEGDaSQV7eqRE
        LWw4SIROpo9TTjad7XgbuHKr8apc0Ah62JDk+hWskm8r
X-Google-Smtp-Source: AGHT+IFOPTzzCoszZBXr4qybsspcf+acjwagubIJlCWG+bWW1MCd7mKnZ7jxvXT/+H8IZbDQk7qQRi+ufQh6red5VmA=
X-Received: by 2002:a4a:a708:0:b0:571:28d5:2c71 with SMTP id
 g8-20020a4aa708000000b0057128d52c71mr2582600oom.2.1697727177726; Thu, 19 Oct
 2023 07:52:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Thu, 19 Oct 2023
 07:52:57 -0700 (PDT)
In-Reply-To: <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
 <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
 <CAHC9VhQYxOAix_kbDR2oCfWGG1YRCV5DrGS_x99U03vmA6wUdQ@mail.gmail.com>
 <CAGudoHHGZCgcSZ8MmpBRSj+=-Kkn6q3c521d3JKiTm9xUe5N2Q@mail.gmail.com> <CAHC9VhTqh93PZ8uwwTVTKZTH7_GHsjhqV-CLpFRfTq2vJeQcCA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 19 Oct 2023 16:52:57 +0200
Message-ID: <CAGudoHHqP6oMcQO8MCx47a0vwv8a8Nb1tHn-kJAj4iFa+Anf2A@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
> Thinking about it a bit more this morning, I think we can safely
> ignore the non-@current case in audit_exe_compare() as the whole point
> of the audit exe filter is to record the actions of processes
> instantiated from that executable file; if the @current task is not
> being logged/filtered, we shouldn't have to worry about the exe
> filter.
>

I did a quick stab at figuring out whether one can get there with
non-current to begin with, but did not convince myself it is not
possible.

That said, should you repost, I think refing and unrefing mm should be a voided.

The bug showed up with 18c91bb2d87268d23868bf13508f5bc9cf04e89a
("prlimit: do not grab the tasklist_lock") which converted that lock
to task_lock. So I don't think pointing at my patch as "Fixes" is
accurate, but I'm not going to insist. ;)

As for prlimit, I think I'm going to add the lock to signal struct for
thread within one thread group. At the same time "remote" prlimit will
instead resort to tasklist_lock, like it did prior to the above
commit. Then the new lock can be converted to a seqlock, so that
grabbing rlimits is cheaper. I'm going to create a new thread about it
later.

-- 
Mateusz Guzik <mjguzik gmail.com>
