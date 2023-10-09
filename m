Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E516E95A8E
	for <audit@archiver.kernel.org>; Mon,  9 Oct 2023 13:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377339AbjJINlA (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377316AbjJINk7 (ORCPT
        <rfc822;audit@vger.kernel.org>); Mon, 9 Oct 2023 09:40:59 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1455691
        for <audit@vger.kernel.org>; Mon,  9 Oct 2023 06:40:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so57698639f.0
        for <audit@vger.kernel.org>; Mon, 09 Oct 2023 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696858856; x=1697463656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVNhOHjJzMqFCSf0hmUndpe+TpUprKUj40Dx+vmyZN8=;
        b=wGYoje4Ji3bjbae59rWy1Ar6xkM1EkMC41bmX7oxT3lxXLq9YCe49ZVxj8TMmkrKW/
         2PTCjsGXRXXcvkiz31zgV9bOyBMp6YN1hX7FuYMVzpVdt6ClolkWuEO4n/jgXPE2GKSi
         M0P0/gzjyOUSUgbZG1K7Xqm5VWVOx7943fN2CqW8hc6NDGBTJuAnsKmsoK5M8Gu+jIXB
         /17iJ5ZB6zLcCxn0cmaFHGIhCbDwTXTbeAAzsS66vvdQlDfvqnyYVB27zUTAnWiQ1iNN
         9XyWpiUDUB4GNiECMW5bNXbeII435HSlehVtkAfLAyB3KzZJBfY6xlYPn8zGpledCWB/
         cFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858856; x=1697463656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVNhOHjJzMqFCSf0hmUndpe+TpUprKUj40Dx+vmyZN8=;
        b=Lo+5Cp3Qr6fLi7lGLHEUY2i6QjFr2Kgmxox4qaqy1eGo0myYO/mQBmNVlFRn91F2ea
         hZqxgAJmIR4Oapd+ER0rzrVmGFKA9Txvl7hyPiCtdQCDWvcyU5GYfb6hrLT/8VrOd3I0
         q2CFcPwqVYro/4uTtzmUQJRN2LxlT+8i3yG6eYg/iFsG9evn7ufrYXEKIpOir7wW4/iJ
         C15s7va3QbkCgK3q0ZAHs4siKZjItnywf11JJZiHq+3ZuIrnK8ojnfeOTygXai7sR3Mb
         ENspWBG2dq2Zt6yKtfwo4U6MANEgC0lZyQjf4Js/1W8e0fsEihqbzw9X7VGvmtkOMrrI
         gkjA==
X-Gm-Message-State: AOJu0YwAYJbTWoKFKFQ8S/s5zaAaYoIw+XmXbDNmA3xswmH5gw1WjJzn
        UbN/sriRcVOjT1tNpi4A7Hlz8w==
X-Google-Smtp-Source: AGHT+IHIF8ihyfGeM12TK9GxoqQSUooPYEzTkojBBNrrrXPmAwxMXnP76Y+jbfND0qLTdvRNKjRovA==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr16439197iob.1.1696858856343;
        Mon, 09 Oct 2023 06:40:56 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c21-20020a056602335500b007870289f4fdsm2361947ioz.51.2023.10.09.06.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 06:40:55 -0700 (PDT)
Message-ID: <23109a06-0f1e-4baf-973b-d0a3d208ea65@kernel.dk>
Date:   Mon, 9 Oct 2023 07:40:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: audit: io_uring openat triggers audit reference
 count underflow in worker thread
Content-Language: en-US
To:     Dan Clash <Dan.Clash@microsoft.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     "audit@vger.kernel.org" <audit@vger.kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>
References: <MW2PR2101MB1033FFF044A258F84AEAA584F1C9A@MW2PR2101MB1033.namprd21.prod.outlook.com>
 <ab758860-e51e-409c-8353-6205fbe515dc@kernel.dk>
 <e0307260-c438-41d9-97ec-563e9932a60e@kernel.dk>
 <CAHC9VhQ0z4wuH7R=KRcUTyZuRs7adYTiH5JjohJSz4d2-Jd9EQ@mail.gmail.com>
 <MW2PR2101MB1033E52DD9307F9EF15F1E85F1CEA@MW2PR2101MB1033.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <MW2PR2101MB1033E52DD9307F9EF15F1E85F1CEA@MW2PR2101MB1033.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 10/8/23 8:38 PM, Dan Clash wrote:
> I retested with the following change as a sanity check:
> 
> -       BUG_ON(name->refcnt <= 0);
> +       BUG_ON(atomic_read(&name->refcnt) <= 0);
> 
> checkpatch.pl suggests using WARN_ON_ONCE rather than BUG.
> 
> devvm ~ $ ~/linux/scripts/checkpatch.pl --patch ~/io_uring_audit_hang_atomic.patch 
> WARNING: Do not crash the kernel unless it is absolutely unavoidable
>   --use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants
> #28: FILE: fs/namei.c:262:
> +       BUG_ON(atomic_read(&name->refcnt) <= 0);
> ...
> 
> refcount_t uses WARN_ON_ONCE.
> 
> I can think of three choices:
> 
> 1. Use atomic_t and remove the BUG line.
> 2. Use refcount_t and remove the BUG line. 
> 3. Use atomic_t and partially implement the warn behavior of refcount_t.
> 
> Choice 1 and 2 seem better than choice 3.

I'd probably just make it:

if (WARN_ON_ONCE(!atomic_read(name->refcnt)))
	return;

to make it a straightforward conversion.

-- 
Jens Axboe

