Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A736164D
	for <audit@vger.kernel.org>; Fri, 13 Mar 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425027; cv=none; b=o2E2mQVBjCksjSk8DT7GBdeL10tABlqnFZ4K93/At7HFMNCXQYRtbB6fsQEPjJ0zJaUDndHnWARXH/RgKqik4uAk8GYy47g08RjsyZJYWaQHaB2/ae9qoarntIzHcD20/g0ME8vAS0xd0YVRcUYI+UHxHY0W6XOg5TiMRLfOL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425027; c=relaxed/simple;
	bh=Vw53QYHKCbG3i2bjJKJQ7E1adE09hd57m/qLrHD7O6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1e3aoCUiGkDUOLsUcS4HjSeafqDNPaxMEQ+hr3YuFuavy3GJkWURqlsVAbzPmRVphv8Gnxew6Tw5fiH7lUHpJWlHe5prqjqZFlXR1gZcsWtUcU3fqyLU0dWuxXCopBBgT0uQ04hiKMgP5XnFtDndPPbE1SHv6pxPMbRHRToyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWdZxpOS; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWdZxpOS"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bea8220c38so1984483eec.1
        for <audit@vger.kernel.org>; Fri, 13 Mar 2026 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773425025; x=1774029825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PSOEv1xERLgXH2ZBdcqMBoKy0zuIxCKcPMy4xL8vk84=;
        b=mWdZxpOSWxtpK8upexkeRRp1Tj4uXKlnfgSalwu40eQRl4fr+6O9jFnQrIbBcG86mo
         tDIC6wppEDWvo8E9AZP5HYrNHFVt8w2YjNIe8PfUoYiRMoywZWsJ/FwTMOqJC+94/K92
         5DCvynQKXQLr0ND9XM7bba1W5f14doEOgvV8sBpBAVdAuKUesCf/3yD7j2Gzv61sPDfc
         vEVzwtXltNLcpDlmacLv2guX3Avea8VgyAX3FVAqEyDQFRPUy03sUs+yKXosO0VBV6W/
         8pZ9YRB8DLri6emjsSQyS0SapiSywMli2LdgZcr+TdcPJk88pNcfc6Q3lYXdp61QS8s9
         2Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773425025; x=1774029825;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSOEv1xERLgXH2ZBdcqMBoKy0zuIxCKcPMy4xL8vk84=;
        b=VIp/CI7/85HxDvFYGl25fTwk789ci51PAEjbbkprrC2euASOlg4HY66kwIIAeCqO0c
         NxR1QGUy23KL09DoyhTYQYKesC/ugkHwNBzhiN4GxnYWaNDEMk9vX0CSjW9UAJrFpQiN
         vCjRZylg0proHbuyUE8/kKvkSf4G5ct/cVLmklgDCqWxDJGOljDH/H8IZ0EX0fF7OyuK
         Lwljpnv0MANllhj443BLjKgtGCOhCnUdk+CyLdT+8hk5KW3lvsf9v/GlvQjEMT1khfkt
         8115WiuhyqmY6p/oIoalkEvAPmHn7R2fYlk9t7PPQe3n+EMgg5yuVWtIcx6CIsrJr3Sm
         7fpw==
X-Forwarded-Encrypted: i=1; AJvYcCXqtV2HuMu6vZtepG8af1MsVyh3H0I1Nm1lV6Lcf1dYPVmnNtKaOHM1/WcF9fJItk10+JKwuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzND1ArMlJ8UWPHdCQupWAQwjmY12jKWtQzBxenH3MDpucZdPa4
	3ZUMgn0uQTLOjOJKiCN3/lwCBrbcE5esrgTC/AizMv+LqalGgwGu75XToI3axuCd4so=
X-Gm-Gg: ATEYQzw2DLp0K5Yz65HXLZNjHosTvbNMARGNmFIBsGd9kmnUzidEQVE2YZOFh6BpVJl
	ShAvDFnOvmqnB8dCFFw71d8WpCWaqovYtZFX/YcRrLh/wl/4wKY2mcqgx7seSwQZ0D6pOi9x9v+
	SNAZFFr5VXisESZ1W8j/WAhciMgVXuj2UjBHCJn5D2/RYgaZ+03OFs2H8er1yeGwW6HVI49Kpms
	AkrO7R7ArnVUncSNBEkDMxnMzMPiJ5yw0lkyXUY00rEO+3GtDGGdjqNlYR82epL02xWy0d9HBdE
	GUfOoFNPLxQTk+K+96LiGwohzM8RbOuRgjsQ8Ucg3SKB8MOYUHV+WG8ns+VrbkI0gcomfzF7e0X
	ola29lMsfGv+7Nlsyi34pZb7dG092+4tiK9O4Tmz5z2rcc72zH8Ca8/Vpcv9PL32bdK01CRclHA
	NxO4tAJuHKiF/S0TN3nq6Jsg9Dm4+M/zexaJ/BgQZ6flpJ6cijx9sAlkoq7eonSQt7f4IBe1GS6
	Ty3vwkw6UpdrluDnxvq3vkBqSUgAmM=
X-Received: by 2002:a05:7300:72c9:b0:2be:8216:57d2 with SMTP id 5a478bee46e88-2bea5442cd0mr2235815eec.9.1773425024417;
        Fri, 13 Mar 2026 11:03:44 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c0:49c8:a562:e69:d236:fd56? ([2804:1b3:a7c0:49c8:a562:e69:d236:fd56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm4197038eec.19.2026.03.13.11.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 11:03:44 -0700 (PDT)
Message-ID: <33904ff8-c018-4464-8876-ec8035e14b05@linaro.org>
Date: Fri, 13 Mar 2026 15:03:39 -0300
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Roman Bakshansky <bakshansky.lists@gmail.com>, linux-api@vger.kernel.org,
 Thorsten Kukuk <kukuk@suse.com>
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
 <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/26 14:48, Roman Bakshansky wrote:
> On 3/13/26 4:59 PM, Adhemerval Zanella Netto wrote:
>>  From the glibc standpoint my plan is just to make the accounting database
>> function no-op [1] (I hopefully to get this in the next 2.44 release).
>>
>> And I think Thorsten Kukuk already adapted most of the usages in current
>> distros [2][3] using similar strategy, along with a better systemd
>> integration.  I am not sure if/when distros are incorporating his work.
>>
>> [1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
>> [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
>> [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
> Thank you for the links and information.
> 
> I have been following Thorsten Kukuk's work. I know that liblastlog2 is already integrated into util-linux and successfully solves the Y2038 problem for lastlog. I am also aware of his wtmpdb project. These are important steps in the right direction.
> 
> My RFC proposes to go further and provide a unified solution for all four files: lastlog, btmp, utmp, wtmp. The idea is to create a set of public libraries (liblastlog2, libbtmp2, libutmp2, libwtmp2) with a consistent C interface, built on SQLite. This would provide 64-bit timestamps, indexes for fast queries, ACID transactions, and schema extensibility without breaking backward compatibility.

I think you will need to check with the systemd developers whether they are 
willing to integrate this idea into their plans (if they haven't already). I 
recall that systemd is extensive in some form.  My understanding is that 
eventually all distros, at least the ones that are systemd-based, will use 
the systemd-provided framework instead of relying on different libraries.

From the glibc standpoint, providing this was always problematic, and I 
shared Rich's view (musl creator) that the interface is insecure and legacy [1]. 
 If I were to implement something not systemd-based, I would follow the 
direction that utmps used[2]: a daemon as the only authority to handle the 
files and all clients (utmp{x}.h} uses will just query through IPC.

It means that users should not care whether how or where the database is 
placed (the _PATH_UTM and related macro should be handled as legacy and 
deprecated), and the client should only care about the record structure 
in the usual C form, along with a version (so no extra concepts on how the 
record is placed in the file).

But I wouldn't put any extra effort into a different API as you did; rather, 
I'd check how to adapt legacy programs to work better with systemd. These 
interfaces are really legacy, and I think we should move away from them.

[1] https://www.openwall.com/lists/musl/2012/03/04/4
[2] https://skarnet.org/software/utmps/


