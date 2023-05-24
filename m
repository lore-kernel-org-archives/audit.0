Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C8FC77B73
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjEXTMW (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 24 May 2023 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjEXTMV (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 24 May 2023 15:12:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408C12B
        for <audit@vger.kernel.org>; Wed, 24 May 2023 12:12:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af31dc49f9so16954821fa.0
        for <audit@vger.kernel.org>; Wed, 24 May 2023 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684955538; x=1687547538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHfAQ+BQsGAj5xPd5WK7V8D10wuVyH5E1RHC5ui5qeQ=;
        b=esVa2W0mLmDe6k4W/YN0MjYCfBJtijj0HhMOo34tAUp+irF9ajjIKv9ta0BtVi2bJx
         9S/N79axl1RWs1OCwiUWupetSVbzsl6oLMywLb5C8ekQea+R9gT8bi+D8ML/D5C7lglq
         Owz/zZCZKbyztWIAB5sB2HKOT8AgXZDJ1nPx+kkjYQhFVaFqnl4E3/2hLPoz75bCAhtd
         qubyPmy+0MCIxJbmF8Uq5oTkjoUtj7fW9mE52hNZsrf2aHxIt+SaygamsznNPV4rZ+y2
         UQ98l214cokaYTepXd5TJTb3mNWHvmx39Om5eM242lZxrUOtsxjkHEPebA/E1RU3Kmql
         CC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684955538; x=1687547538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHfAQ+BQsGAj5xPd5WK7V8D10wuVyH5E1RHC5ui5qeQ=;
        b=a9EtbR0OzZlIzKX9ukPjvywP/z6a9Esk6OTQsJMAoPbF7fwmXrwFQgodLP3jTTORgl
         Ia2hSSeAaWXGl3K5NCj6eQuu4hilLGOXX/wxK8wc2ei4YzrHQIvTxX0QOqaQC5O7Xcjl
         LyBFJ7ewz7TcXYhXGHLlscdDaC0vHqWtytvvaK6+ObVqIPLG6tzPqgiUai8OyegFf/SG
         HkKZ2IMlwUkEEz0vVI5PJaFzeQpmSs9qZqCY+nVMLagrfFL1nM7u8GR8OkLm0ehMSa6K
         Ep5qr0A2WxiTVmp2g5llbmb0EqG1cs6aKKkyLixpRNHvEL/v8KXBAL4iWgyZmbFH+J8w
         tZWQ==
X-Gm-Message-State: AC+VfDxwW3qX2iieKcNqYVXxQTdUaadYajv71r9M/f+G0nRzxyPh4Jbm
        SdN0kR14Jfq23DHCeH18rnE=
X-Google-Smtp-Source: ACHHUZ63fd6g3YzXvBflhd64U+Y9RUI6EEaA9YkoWUwwE5Uvfkozl14FUSncbwc7QmitUBy7f6l9GQ==
X-Received: by 2002:a2e:b0d4:0:b0:2a8:a5b7:6057 with SMTP id g20-20020a2eb0d4000000b002a8a5b76057mr204015ljl.50.1684955537786;
        Wed, 24 May 2023 12:12:17 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.185])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e3807000000b002ad98ec6b10sm2189120lja.52.2023.05.24.12.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:12:17 -0700 (PDT)
Message-ID: <06f60953-b6a3-0e13-6dad-479a7258910e@gmail.com>
Date:   Wed, 24 May 2023 22:12:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Auditd doesn't receive syscalls after installation for the
 current shell.
Content-Language: en-US, ru-RU
To:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org
References: <b5e87a11-7605-6745-516a-8004569bbe5d@gmail.com>
 <2151809.irdbgypaU6@x2>
 <CAHC9VhThSLtni=JuStofi78=18SdH+VCUA4eGdOkbM9=J+wzLA@mail.gmail.com>
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <CAHC9VhThSLtni=JuStofi78=18SdH+VCUA4eGdOkbM9=J+wzLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org


On 24.05.2023 17:53, Paul Moore wrote:
> On Wed, May 24, 2023 at 10:46 AM Steve Grubb <sgrubb@redhat.com> wrote:
>> On Wednesday, May 24, 2023 7:37:27 AM EDT Rinat Gadelshin wrote:
>>> Hello there.
>>>
>>> It seems that the kernel doesn't send messages for syscalls of the shell
>>> process from which auditd is installed.
>>>
>>> Reproducing steps (performed on Ubuntu 22.04 x86_64 on virtual box by
>>> `root`):
>>>
>>> step #1: $ apt install auditd
>>> step #2: $ auditctl -a always,exit -F arch=b64 -S openat,renameat2,unlinkat
>>> step #3: $ echo t>delme;echo t2>>delme;cat delme;mv delme d;mv d
>>> delme;rm delme
>>> step #4: $ service auditd stop
>>> step #5: $ ausearch -f delme
>>>
>>> There are syscalls from /usr/bin/cat, /usr/bin/mv, /usr/bin/rm but there
>>> are no any syscalls (openat expected)
>>> for /usr/bin/bash (current shell process) for the file.
>>>
>>> If step #3 is performed from another tty, then openat syscalls
>>> (CREATE for the first echo and NORMAL for the second one)
>>> is logged for the /usr/bin/bash process.
>>>
>>> `uname -a` returns: Linux grin-vb-ubuntu-22-0-4 5.19.0-41-generic
>>> #42~22.04.01-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 18 17:40:00 UTC 2 x86_64
>>> x86_64 x86_64 GNU/Linux
>>>
>>> Should I open an issue for the case at
>>> https://github.com/linux-audit/audit-kernel ?
>> Are you booting with audit=1 ? If not, the install process and any before it
>> are not auditable. You will only get events for processes started after audit
>> enabled = 1.
> It is also worth noting that some distributions (I'm not sure if this
> applies to Ubuntu) effectively limit auditing with their default
> runtime configuration, see the wiki page below for more information:
>
> * https://github.com/linux-audit/audit-documentation/wiki/HOWTO-Fedora-Enable-Auditing
>
Steve, Paul, thank you!
It make the situation completely clear to me =)
