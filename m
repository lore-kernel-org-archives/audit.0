Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B9C7EE2A
	for <audit@archiver.kernel.org>; Fri, 19 May 2023 20:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjESUyy (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 19 May 2023 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjESUyt (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 19 May 2023 16:54:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C3E56
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f4e01eb845so21876141cf.2
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529681; x=1687121681;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZJNVK9YHaPAbF2Jn7/P/L0YwULKWY8OB/ImBEt7x7E=;
        b=YdZl+ccDAxVN2DMCdmj00qkO2tPC+dQvZPSNysED3Ax005/f9zrshUY9gqlpSJpvZz
         CbY1/Z1WXLDwGjr9GT9k+W7giHhNlVtgqbG/reHlnILf+tJwzFYqh+VMwoQoQOrhXKpD
         vvRsI/G9E6nZTTyncWvYrjLPxXw4Bb06c/0ZnZU+h/IcHGh7aImsPAeb357JkizagO/q
         UgVgFDJk7/Ir+kLhuhUG6wjFqtWlE2qdbWp+phlaNT3FQnsm1iDHw/GU5GlF98TNsCIw
         BTUJdqjyrilhNPhORDCW9XDDoIkamEDcckugIhTjePRsb1mUdVD5Fiu6H1Qovd5+sZoL
         D0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529681; x=1687121681;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZJNVK9YHaPAbF2Jn7/P/L0YwULKWY8OB/ImBEt7x7E=;
        b=NuddHimu59SSBBrAcKrBS+FxuUjf/p7iBKfsl0IoXnlHw0IU1+frkciAsk2SlA0l4Q
         vixaJN8t8bGv+nxUeuJCVOuH4mEnYlfoL2v3tYhnG3Io+X3szJkiLmuEiv8IFRZYgTsu
         7VEGXX+1mRofnimoDobZ8jpqQ7HBP9laEDR+4auAO8REH7NJu1ba2yzRYD8CPBxc3utz
         191H8Um0XMaP7hQN7sh9fA4GFpkUAfTdIBTnCSqBXuT2cCV+v2GxtKfjo/OchN01auwY
         ct/eoT9UUr+LzYaa0E5vza3Yi1sv0TJ95NXdY6CoqXw5HwL2dXbqPLorJQce0GxRk3CI
         NI9Q==
X-Gm-Message-State: AC+VfDx0vAGaTMaI/KDS5VNBdVruZkdw9PXWuks0g7UOAFzqCPHEEIEF
        u3IXqX2V4eGWBhZrioIHJ+Mb
X-Google-Smtp-Source: ACHHUZ55ceatKrdBNbR/Jk/XfDh8VQ2nP21sDg5bmFTKmCUsyk2VfM7aQx9hdwV/FwNQmnBAFYnrFA==
X-Received: by 2002:ac8:4e91:0:b0:3f6:9c1b:911c with SMTP id 17-20020ac84e91000000b003f69c1b911cmr1581546qtp.44.1684529680910;
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z8-20020ac84548000000b003e4c6b2cc35sm124639qtn.24.2023.05.19.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:40 -0400
Message-ID: <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 4/5] audit: check if audit_queue is full after  prepare_to_wait_exclusive()
References: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> Commit 7ffb8e317bae ("audit: we don't need to
> __set_current_state(TASK_RUNNING)") accidentally moved queue full check
> before add_wait_queue_exclusive() which introduced the following race:
> 
>     CPU1                           CPU2
>   ========                       ========
>   (in audit_log_start())         (in kauditd_thread())
> 
>   @audit_queue is full
>                                  wake_up(&audit_backlog_wait)
>                                  wait_event_freezable()
>   add_wait_queue_exclusive()
>   ...
>   schedule_timeout()
> 
> Once this happens, both audit_log_start() and kauditd_thread() can cause
> deadlock for up to backlog_wait_time waiting for each other. To prevent
> the race, this patch adds @audit_queue full check after
> prepare_to_wait_exclusive() and call schedule_timeout() only if the
> queue is full.
> 
> Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK_RUNNING)")
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

I discussed my concerns with this patch in the last patchset, and I
believe they still apply here.

--
paul-moore.com
