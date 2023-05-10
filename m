Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793DC7EE23
	for <audit@archiver.kernel.org>; Wed, 10 May 2023 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbjEJNuH (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 10 May 2023 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbjEJNtv (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 10 May 2023 09:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBAD067
        for <audit@vger.kernel.org>; Wed, 10 May 2023 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683726511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88+A9qHnqAysgunfcfDZ1GUsvcdV96MF7QkKOgfeNPA=;
        b=MF+KPo2kwJx8rSxJTDpOkj6xBGzgXKz+RFEj3hqDTGdpDqnJ5WU3Osjm+Wobv0kmC4HM67
        4Nkg7L/iTt+L6/M0wb+ucO23r36KrTy4/R6KaoSTiC/VQ+iORvk+yoEsjDHAIBzXv7a1C0
        ILGhKSJK7+gFdevxxE1WLgBy/EjkVsA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-2JoAGjEXM8azWQ80xns9dg-1; Wed, 10 May 2023 09:48:28 -0400
X-MC-Unique: 2JoAGjEXM8azWQ80xns9dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E05A98517F2;
        Wed, 10 May 2023 13:48:27 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.17.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3874078908;
        Wed, 10 May 2023 13:48:27 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Rinat Gadelshin <rgadelsh@gmail.com>,
        Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com
Cc:     audit@vger.kernel.org, linux-audit@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Date:   Wed, 10 May 2023 09:48:26 -0400
Message-ID: <12214633.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <f2c12d41-95bb-6e56-4d68-8a4b50ca59fd@I-love.SAKURA.ne.jp>
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <dcb7759f-ffd9-b414-f68b-44707a879312@gmail.com>
 <f2c12d41-95bb-6e56-4d68-8a4b50ca59fd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Wednesday, May 10, 2023 9:30:19 AM EDT Tetsuo Handa wrote:
> On 2023/05/10 21:12, Rinat Gadelshin wrote:
> >> Please try to find who is calling audit_send_reply_thread for many
> >> times.
> > 
> > I've rebuilt the kernel with 'dump stack()'.
> 
> Oops, I thought dump_stack() shows pid and comm name, but
> it is dump_stack_print_info() that shows pid and comm name.
> 
> > As far as I can see, it's the exit of `sendto` syscall.
> > It seems that the kernel just creates a new kthreadd for each sendto
> > syscall. But I think that I'm wrong and just missing something.
> 
> Yes, sendto() on netlink socket calls netlink_sendmsg().
> For some reason, audit_send_reply() is called for many times.
> audit_send_reply() is called by audit_receive_msg() for the following
> types.
> 
>   AUDIT_GET
>   AUDIT_SIGNAL_INFO
>   AUDIT_TTY_GET
>   AUDIT_GET_FEATURE

The audit userspace always adds NLM_F_ACK to any netlink communication to 
make sure it did not get discarded before it arrived. It has done this since 
before I started working on audit code.

-Steve

> Would you re-caputure with
> 
> -	dump_stack();
> +	pr_info("%s %s:%d type=%d\n", __func__, current->comm, current->pid,
> type);
> 
> ?
> 
> Regardless of the result of re-caputure, it seems there is no switch that
> can prevent audit_send_reply() from calling
> kthread_run(audit_send_reply_thread).
> 
> But since kthreadd runs with PID=2 and PPID=0, you might be able to use
> PID=2 and/or PPID=0 in your rules in order to let kernel audit subsystem
> ignore kthreadd. (I can't test because I haven't found how to reproduce
> audit_receive_msg() in my environment...)
> 
> # cat /proc/2/status
> Name:   kthreadd
> Umask:  0000
> State:  S (sleeping)
> Tgid:   2
> Ngid:   0
> Pid:    2
> PPid:   0
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit




