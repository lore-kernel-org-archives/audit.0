Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE64BC77B7A
	for <audit@archiver.kernel.org>; Fri, 19 May 2023 20:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjESUzI (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 19 May 2023 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjESUzC (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 19 May 2023 16:55:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01329E5C
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f3a287ecceso18359401cf.0
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529691; x=1687121691;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT/C0XPR1/vAySbbcWPHa11OWVLeot7aGDtepqZ5u+E=;
        b=Fzpv6g6j9JdQ5qU4l/xb842q1z5+UkjDHlLY6GBqPnMz7JJ90LpHl9lQMIXEXAdt7L
         kCtHAyXUH+/1pZOxCzeIWHqsokl5ApepZfrrA1g+huffuTVAFPJHCpUK5KIRl4nlwpmo
         CLMRD7bKgPBWl0WPoDsIzm1FLTGSDNZpZt4FA+/IFWb6KsC5S3qazb1ahHMBtHlev5st
         LkWKPSpJBhqoYXOK3Z5Cg/KGYka7gVb+0Vf7UZ6S0qOZqwhpxeOBUT2odm2m0hpeUyqw
         bqkdX+mMu/geDMemxcFb8Dun7kC/Qud0/44KZAAbty+Nk+SXBdQa4V0FsAyLY9W9p9d/
         wmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529691; x=1687121691;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT/C0XPR1/vAySbbcWPHa11OWVLeot7aGDtepqZ5u+E=;
        b=MX2wf4QEOLp9WawLzBu9c1SYdh/0pK3aweNXLB+p2avPQf5X87jN2O0IjtoAaCWqYw
         H6xNiqyBqIm6hsKeTYP4gkW8Jy+wFfPCDggAIlMFEjZIr/RniF3wcaiH/hAFVyOnFHFg
         E8C+vTmlOqZulFb/jbgyMRcrq27z3LUplkMLSLpsr3+Ns97Juqn1rS5xpqU23jSwAFOQ
         Np0wWKlCYeRQVDvmzJn+3ZBX/4El+tepMu1exxuor40YwlUCN/zmhtblZwYZCct3gmi8
         ldOkn+DgX2tuWh3GfL2RCRwE3DGnhVE0wftfOD99WmRuao6zQDYQNBgQsfhidxkZbw+/
         dFIA==
X-Gm-Message-State: AC+VfDxP6HIJzZjag8BSN4tTb7PFxrE7vAAOawvtzPEI3cxhgrBqiXxU
        r7dOAfWdFeVi24XOzOvnNSK2
X-Google-Smtp-Source: ACHHUZ4Eb9+VnEO3olqncqK/5kIuTihkBSrRY2ybG2/tnS/lpVpz98AMcdon7Pa4MB98bZw8MRhYEg==
X-Received: by 2002:a05:622a:510:b0:3e4:e641:6b1f with SMTP id l16-20020a05622a051000b003e4e6416b1fmr6106651qtx.55.1684529681813;
        Fri, 19 May 2023 13:54:41 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a149800b0074de8d07052sm1372238qkj.47.2023.05.19.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:41 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:41 -0400
Message-ID: <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 5/5] audit: do not use exclusive wait in audit_receive()
References: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> kauditd thread issues wake_up() before it goes to sleep. The wake_up()
> call wakes up only one process as waiter side uses exclusive wait.
> This can be problematic when there are multiple processes (one is in
> audit_receive() and others are in audit_log_start()) waiting on
> audit_backlog_wait queue.
> 
> For example, if there are two processes waiting:
> 
>   Process (A): in audit_receive()
>   Process (B): in audit_log_start()
> 
> And (A) is at the head of the wait queue. Then kauditd's wake_up() only
> wakes up (A) leaving (B) as it is even if @audit_queue is drained. As a
> result, (B) can be blocked for up to backlog_wait_time.
> 
> To prevent the issue, use non-exclusive wait in audit_receive() so that
> kauditd can wake up all waiters in audit_receive().
> 
> Fixes: 8f110f530635 ("audit: ensure userspace is penalized the same as the kernel when under pressure")
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

This was also discussed in the last patchset.

--
paul-moore.com
