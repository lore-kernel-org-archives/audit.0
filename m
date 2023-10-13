Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB60CDB47E
	for <audit@archiver.kernel.org>; Fri, 13 Oct 2023 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjJMPxi (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 13 Oct 2023 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjJMPxh (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 13 Oct 2023 11:53:37 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7FBD
        for <audit@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a29359c80bso20138439f.0
        for <audit@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697212414; x=1697817214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=bMCaOVPLmjdUUJk41icyyKvHf1jHZrvZQoTWQ4b1Ya5gbBeRrnMoRTgUwfP4imhfvI
         MbwEz9u096CsLR/j76Wn9e4rzzt2v0fbiJcIlhO9U/HgNNJqagGnkqiwz+Fek/TbMqOK
         bKacmQD095tA5wDxDPeRrSLk3sKybZsOg5nkSr6h/4iOJtyLmMTLuz5SYx2q/TzJwGNK
         CVJ+PJI9v1mR2ssV4Uevdktyw6xc0zV+lAlK1mAYCMVGg5kMegq4I4FLcxjuodOGLjoN
         Iqwv4QtiuCX8wLvZAXStKGMyR8tfCvh6yjsBKuQLf/flv/DozNgCZU2PRevqWvUWp14H
         ADLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212414; x=1697817214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=im8N24aLdl4KmOgK4BCosYWZoLg1rA+6WZ9Qp6rpCVnJvOyqcWXytv8USbDIc2yKQG
         DF04W7U6QIHF9kvIknX0xqttjTXC76qMhiY/vSghVmOhYMsKZvxQzzroEcPoUiibDqZ4
         CbVNwvQ/YkG9WVwOr4dOe0ApUDb9iyeNVBK3YpsTDIoFUVVesvBr5Tred7ASSMin0aCz
         97wOamU1Y5NJcSs7Wf2lFoQBTvJ5nqkf0vVdIx6y+bbLvAiJzpKd4ykfaSLkAH8+poMj
         G5A7Yavm45/G9IPHsZfhssR8eASMCueZ8dNETn0XAmO6Ex9P+Ubwy4sS1H49FvWVKUls
         A4Bg==
X-Gm-Message-State: AOJu0YwsH4gGq+LoRDYflXhy4xms68uOoWs9xpK0+EsbC8U5rxsBvweo
        aWLvIBRqsL9JbAzFxGTu3KlBlQ==
X-Google-Smtp-Source: AGHT+IGD+Y6udldFEfNzSbeSH4ZSFKpxb16IumSgm5Ax2wKNRo/VZ1i60Er7mUo8Y6PAYB6BQM7MWg==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr26797941iob.0.1697212413928;
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d24-20020a6b6818000000b007911db1e6f4sm4935706ioc.44.2023.10.13.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Message-ID: <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
Date:   Fri, 13 Oct 2023 09:53:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Dan Clash <daclash@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
        audit@vger.kernel.org, io-uring@vger.kernel.org
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231013-karierte-mehrzahl-6a938035609e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 10/13/23 9:44 AM, Christian Brauner wrote:
> On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
>> An io_uring openat operation can update an audit reference count
>> from multiple threads resulting in the call trace below.
>>
>> A call to io_uring_submit() with a single openat op with a flag of
>> IOSQE_ASYNC results in the following reference count updates.
>>
>> These first part of the system call performs two increments that do not race.
>>
>> [...]
> 
> Picking this up as is. Let me know if this needs another tree.

Since it's really vfs related, your tree is fine.

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

You'll send it in for 6.6, right?

-- 
Jens Axboe

