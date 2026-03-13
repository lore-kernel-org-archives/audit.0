Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4F223DFF
	for <audit@vger.kernel.org>; Fri, 13 Mar 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410359; cv=none; b=J4BYRSVjd51b4G+38qs/DmsoyOENDgUG9K0qNo0mxEf1NQ456isWE9vKgZhKgs/chZok7qNWUZS2ibqMREK5igGlWBGKRLfTja5nSaV6DMS5Zdjl/GlXj4DQLeuXukWJgbCaBcA4oTQxJ5h4KNKViY2ij3FbiKg6zh614h2dLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410359; c=relaxed/simple;
	bh=G/2GudsY16WgckOKKpfCxUlxP4/qeV6zEYS3Nvez+uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM4/VcaHlpO/VGTZrKuZpExmzxOJ7JXWBrDGezy7+94A+lIEn4lV0WS0iPoMbaIjSkkgDtWVXidZbWk6wNki+B94HoA/SksL4fm6eAXpXZctCP/P3GYHDNFJp9fw6/MSJPv9m2rKzKzgi4PsyeJ1Kzk1rof3VctJoc5u2rm8FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhtvxNdH; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhtvxNdH"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso2490207c88.1
        for <audit@vger.kernel.org>; Fri, 13 Mar 2026 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773410357; x=1774015157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkQxYDJ/fqj9oY7QWpa/xMQehKB5EfjV0laBIMwYETk=;
        b=FhtvxNdHdQQUMoluj48dS4qncQ8Ga937qqCYBIH3lR5C4u4neBazdQy2RX3gnQn4fd
         uihMazCPWX95obOgk4XWsCCQriE/71MokVt5aafuXhejlg8z5sbcP2x+kTCV5akrxpFL
         c55tKc5AKqxw5CMnsHJx+QmB78GjD41MulAOMFs4tsZLwOI8U8Ibh4qV1AdBaoOjTt46
         5hiAtRQzsSNXuay2ABZibkID0u5+UBgubBE9nlyvye7bTksiorIIXTlWJpvlRtp5jvlw
         W9seW8CNb1iQKiU5UqXjiFcszriZIT07JXuH4jaeSFc30+9td7/+23fJ8MMY7Edhnt9z
         5OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410357; x=1774015157;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkQxYDJ/fqj9oY7QWpa/xMQehKB5EfjV0laBIMwYETk=;
        b=B7Mkjz2XYnbLFFxhqIa6QItC9SD1ysouElIhQjsgKSO3EVe7BkeMhL61Wj1pQ8Fa6F
         AlONEZvwJ6fcHHBz8jKilRxGhjSoWWzpLXijKhiN59YgGqwex0q4HmIr6YXjTVkWkNfN
         KsCu0jQYH6UC2SRB2x0Bx0P+j+XEGbndoso2CsZn2E/5C1Lgp0VdaaMreiz1MwOKowHd
         iW4OE90VtjgUD9Vnqc4TsWbfd1M5IoyJnzGANohCJirsr09p69upR9vsqvfVuADbCmcN
         NTssHPAmJekwWmNS+/DaLBusFnrpC9tv0q67dmlrCPoQn+ipCUElDZbg1kb9mog3xYRg
         HdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLQPbXBOjK23Px8Ei/7FtBlb2FojoONgsmFEl3pAT660zo16AdtieOlgtfYOy2ibC0j0YMTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GxTPEsGWuhs4CZPz58Pboj/6AvH0qS6iIlumLLrn/ypYPimX
	Qx08vve7q+YWt62sl7h8LvlNTPo0bLVNRaqlMJ7zfR8RQy0zV4/Y5y7xmUBoRLj0MJs=
X-Gm-Gg: ATEYQzwCAozeEPi7lPsOeJXImq2OSSmpwu+PcQn6ufikVRqyoZVqnMQTPSHVV22YROe
	3sd8uJ9qJWH8y0W9qQzKTqZ9Eir4j3HvOeKmEzpiMue0UMk+/rG5zgoWdbajwtyBkfkIr3Me6BJ
	y7UjaZLF4i1/xqJEf/yQGvGMSaVTb+s2UcvfB3d2dvHGZwsulPF+NrSa0JCaoh3BdQn82WVjBj5
	No6nnZMDGJ+XZd6/Ua4K0s/onRcpBeXP9hmUsccK2Z4O5BDInjp67w9WXJxtzn9j9MxJblRsUNq
	JbGWQr+TxPyeqbRe2Yrdzj2WUpEo4G/Ut8o9rTI1P/OcaWzelJ9KgBZ1lkms1JkcVjgA6qN0JQp
	JxqKXTpWH8ZKGviCzsKhI60q8XGRLixTl0BxJHNmnhUiPlE2/Zj72lyIXMEI9V9uyjdumxBKXcO
	UMhtLWNMvqpgVZHMkkUOfqG8R8pS+D1hEkX1lGvvHUjamPcPRT4Wodw5e7SLfOkAw5J0HQZlAgm
	6q1XMnfZiKDI7H8snPy7ulJDl/G78k=
X-Received: by 2002:a05:7022:6283:b0:122:153:d161 with SMTP id a92af1059eb24-128f3d7b662mr1856388c88.17.1773410356653;
        Fri, 13 Mar 2026 06:59:16 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c0:49c8:a562:e69:d236:fd56? ([2804:1b3:a7c0:49c8:a562:e69:d236:fd56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm2417528c88.15.2026.03.13.06.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 06:59:15 -0700 (PDT)
Message-ID: <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Date: Fri, 13 Mar 2026 10:59:11 -0300
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
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/03/26 18:01, Roman Bakshansky wrote:
> Hi all,
> 
> I'd like to share a draft RFC proposing a complete overhaul of the legacy
> binary logs used for authentication auditing in Linux: lastlog, btmp, utmp,
> and wtmp.
> 
> These files, designed decades ago, are running into fundamental limitations:
> 
> - Y2038 problem - they use 32-bit timestamps (time_t in lastlog,
>   tv_sec in utmpx). Even on 64-bit systems the fields remain 32-bit
>   due to ABI constraints, so all Linux systems are affected.
> - No extensibility - any new field (e.g., container ID, service name,
>   source IP) requires changing fixed structures, breaking all existing
>   tools that read them.
> - Poor query performance - tools like last, lastb, who have to
>   scan whole files linearly; with millions of records this becomes
>   painfully slow.
> - No atomicity - partial writes during a crash can corrupt logs.
> - Concurrency bottlenecks - multiple writers (sshd, login, etc.)
>   contend for the same file with coarse locking.
> 
> To address this once and for all, the RFC proposes replacing these logs
> with dedicated shared libraries that use SQLite as the storage backend:
> 
> - liblastlog2 - last login time
> - libbtmp2    - failed login attempts
> - libutmp2    - current sessions
> - libwtmp2    - login/logout history
> 
> SQLite brings:
> - 64-bit time -> Y2038 solved forever.
> - Indexes -> O(log N) queries instead of full scans.
> - Extensible schema -> new fields can be added without breaking old tools.
> - ACID and WAL mode -> atomic writes and concurrent access.
> - Portability - runs on any Linux system, no systemd dependency.
> 
> The full RFC, including preliminary database schemas and API drafts,
> is available in the discussion repository:
> 
>     https://github.com/bakshansky/linux-auth-logs
> 
> I'm looking for feedback on the overall direction, the proposed
> interfaces, and the open questions listed in the document (e.g.,
> library naming, database location, fallback options for embedded
> systems). Please use GitHub Issues for comments, or reply to this
> thread - I'll monitor both.
> 
> Thanks for your time and input!

From the glibc standpoint my plan is just to make the accounting database
function no-op [1] (I hopefully to get this in the next 2.44 release).

And I think Thorsten Kukuk already adapted most of the usages in current
distros [2][3] using similar strategy, along with a better systemd
integration.  I am not sure if/when distros are incorporating his work.

[1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
[2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
[3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/

