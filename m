Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE23C7EE2C
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 10:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjEXKiR (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 24 May 2023 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjEXKiM (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 24 May 2023 06:38:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436A13E
        for <audit@vger.kernel.org>; Wed, 24 May 2023 03:38:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so729556e87.2
        for <audit@vger.kernel.org>; Wed, 24 May 2023 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684924683; x=1687516683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aIc+W4jRozyQKjGPCOdblhKfCTo6UqCtNr9GJSvrD0=;
        b=GbgY+QuZZIfe5ye3TrXEwZKBOH0vJi4aI9jtXMkNotSfy30bvQaJV74qvKZaKmS06V
         a6wcO7GRTp67LnT+4FBtLhUybuV85ZYgUtsfcJJnWhk9ybGbi7lmEP/CRUKHwmAPamre
         8speVllNKnGUs8FuZkQvqP5WijdriZdIXX8p3JhuT8jEpK8w8mw7QP9X8/GFjc8ve+fQ
         1eME5Gjf15pvEzW5g/XOp2xhDJUOTNnSkRmAX1xuwWsrHUusINNvyP3oQ+Ngmp2SsUiF
         eTjr/w9Lq0AzfKa1Iu0f+3B8XYbTe9Uu4TTB63ySoblGWf3Dk6FhBGArCHLYy/pT7vMA
         QP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684924683; x=1687516683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aIc+W4jRozyQKjGPCOdblhKfCTo6UqCtNr9GJSvrD0=;
        b=PRMbvcPPJEh6zh2wbM0YYEQhsliL26Ak/kdnIyrV6vnV8+hAXm9MnuPEqHtVatWarn
         zJR1/NWOZhMLK9BwlASFdavdqfIzQMzEaYIm2W+2XjD6uqGYBITmeWGN4wf96CCIUcaG
         pX6fWqwBq8a0Jy4UwxyKra9HtkdyiU1XAq1dB5ZHrvQXWCqTmW5aGJ2R2N1GXZbCZDnJ
         9xTvIpG4ZvUXXPAni2XPF1GsOSp6SskFfaZWpyY9IrySKaUOZBdgxMuMWQmny37XZrKy
         n7zkP+QteP7hVDLubH+H7DQnIiGa8pWv7rgj6Zq6531MH5JOItCXeHD4bE2DfKzkSr4l
         iYnw==
X-Gm-Message-State: AC+VfDwNAJ7IDHOby9HMq1ADgSwxsg+Mo12DsEovTJeUoD3XilzUmz+9
        U/UEBtaFnF7+JpNgRk9c/0SCTvoE4vTZRA==
X-Google-Smtp-Source: ACHHUZ7g7cPceUMikyYVFWz/WlBSc4fZEWypRDBoGCo+aCDkVp8a3751hHLICOTYJfkAW8YcXV1isQ==
X-Received: by 2002:a05:6512:489:b0:4f2:7c91:93f with SMTP id v9-20020a056512048900b004f27c91093fmr5649928lfq.21.1684924683061;
        Wed, 24 May 2023 03:38:03 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.185])
        by smtp.gmail.com with ESMTPSA id z4-20020ac25de4000000b004efee5841b9sm1656965lfq.290.2023.05.24.03.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:38:02 -0700 (PDT)
Message-ID: <8406cb9d-0654-b41c-64f9-01aba486b849@gmail.com>
Date:   Wed, 24 May 2023 13:38:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
 <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
 <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
 <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
 <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
 <0e748195-d3ba-88c5-1b1e-5a9c447bea57@I-love.SAKURA.ne.jp>
 <dcb7759f-ffd9-b414-f68b-44707a879312@gmail.com>
 <f2c12d41-95bb-6e56-4d68-8a4b50ca59fd@I-love.SAKURA.ne.jp>
Content-Language: en-US, ru-RU
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <f2c12d41-95bb-6e56-4d68-8a4b50ca59fd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi Tetsuo.

Sorry for my log absence.
The kthread-spam problem has gone when I've switched to using 
unicast-netlink connection (like auditd does).

Do we need to make another test with the additional pr_info() ?

On 10.05.2023 16:30, Tetsuo Handa wrote:
> On 2023/05/10 21:12, Rinat Gadelshin wrote:
>>> Please try to find who is calling audit_send_reply_thread for many times.
>>>
>> I've rebuilt the kernel with 'dump stack()'.
> Oops, I thought dump_stack() shows pid and comm name, but
> it is dump_stack_print_info() that shows pid and comm name.
>
>> As far as I can see, it's the exit of `sendto` syscall.
>> It seems that the kernel just creates a new kthreadd for each sendto syscall.
>> But I think that I'm wrong and just missing something.
> Yes, sendto() on netlink socket calls netlink_sendmsg().
> For some reason, audit_send_reply() is called for many times.
> audit_send_reply() is called by audit_receive_msg() for the following types.
>
>    AUDIT_GET
>    AUDIT_SIGNAL_INFO
>    AUDIT_TTY_GET
>    AUDIT_GET_FEATURE
>
> Would you re-caputure with
>
> -	dump_stack();
> +	pr_info("%s %s:%d type=%d\n", __func__, current->comm, current->pid, type);
>
> ?
>
> Regardless of the result of re-caputure, it seems there is no switch that can
> prevent audit_send_reply() from calling kthread_run(audit_send_reply_thread).
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
