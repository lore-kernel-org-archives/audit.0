Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371F2F32
	for <audit@vger.kernel.org>; Thu, 30 Jan 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198827; cv=none; b=HqAqqw9Shi/nh7RojGF8qoXcz4E2RB4+6DTl0ilPAbAaeBDwxdytzwiq5BlOj/2nn75jWEi8uVY4gq+Y7GKjkwrKuVCrOeZ3XGxtWrV6o1q3B+dK3iQXGHFjwTB0e4rDzD+f2j9GOanq3wOgQ85SsykUy3CuHsu+3GVYzys/reo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198827; c=relaxed/simple;
	bh=gDdLlLY96LiStuvimQHbYFWJtnuNfhr4Ul8KlJuj/jk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AZvSpTIcYWRg2nuwwmnOLRJclRpHxIXZREzVhyicn7bwXf7sH+58KYFOt6/HAhQW1lnQE4N5ulk7uQOuI//dxSN8cmbEebwsA0it1lohdU05DDjnkqvQdptYWdrgawgT5NrpYyOi7g28Yq14YJSZ713N/oJk2OJk5rQKkr0M0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=grYieowW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="grYieowW"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6c3629816so18918585a.1
        for <audit@vger.kernel.org>; Wed, 29 Jan 2025 17:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738198823; x=1738803623; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50YnZfhZ1EwddeerDDyK0b3+VDRyxiKAG8Byj60y0A0=;
        b=grYieowWP2Sd3vX2yzPvI1T7WaTE6MHoY8GBU7NrM2sUcHFI5vD9PMauK4uQRViXEC
         O7OQjWLnNTxeUcM+nqqwsA+IJtcSyxvs+rTPpjsbHXbLcXVWbPQHuJ99AncLKxLNjZ6F
         +JZZEbsA+y52HUDfmjRCCumMwOnchuwuH5hkaCxnmZHcLjsKYS/AY3aI2uH6+qbnn6Ig
         boDbwDkBM6oEvJFA76eeXI6y4jQTJf3LH4ozm5ufjxlcEUmhmN8aF90Zvs9n3a7gaE7a
         Zkibv54GmeMgE8LD1fB11ATFodk+V+KkWDb2Ij3r6TBzOvILhTMk9UWzLz8UeyEbz/Cz
         a7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738198823; x=1738803623;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50YnZfhZ1EwddeerDDyK0b3+VDRyxiKAG8Byj60y0A0=;
        b=vlZ0RLbF//3xtkK50FXF0C+eAU20IGnpBe5eWNjFfrmK3ASUKthZoOrcRz0M2fJl1+
         W7lLJqJiL3SnrRlf9czwlz/zhZXYEheJKcMz9h6W8RkV+LWpMXpW8mwdrTHW1lwLhm7q
         399JNgM/GpYwofNuy+DOYX87uYKdgqzd8GUe8R4mj5qSZeEUM/FCnvAbN1NamOBROYXa
         MiTDVDjQkbigFI0sgPGu2zHIDOceo4fQMWeTy7RMDfuzy2JBHiKDJJ0bBALw9dVo3EcG
         5rlakm8FA0c6bY904ZsvZJaT6eIQhihAPm+5rt113NBH1LzenRRPp9AenoqH50jEQ4P3
         O7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXrLTQdXrrxLYTuO4DEJCgohimIcQxfRyMzX6HBotxOKgCwQwP4SvZ63T0/E3NFPaEIelV+ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2UW3aIUamiYzEUtnPhtOe8yBtPPJ8zr9hCJl/cZYgfT39l2H
	urDzdqVh6X7Mf1XicecZ7BIHVZ2rgrDTGkWv1kr7ZRoNfus4zEf/PtS9CwpKCw==
X-Gm-Gg: ASbGncvDBZnXRHtBUhir7GSYA+8uAYhFLyduo4ZCDLThVRTQmf2CBxq8jXIMdlbtXiq
	JjxYh3YeVzB8YLapmidnN92nqWewPYuTJXAYrhSvHA2iGeo8N2Y7/GAXvuamiQ2vM7qgrwKDCP5
	BBya54X22vy7RIQrKPp9owGnInHq7CgD0Y1bZX04oMqlUBdLZVbLvbomAhxXwgRqh5XyiDueq+K
	miGpJ0p2GbJYHjRV6U0M91z/R8qtfAxJf+lSo6cslZPFCLxWy37qJtaDiNEAhc6tm7p9ztcgjlC
	NXW8JG+yKg==
X-Google-Smtp-Source: AGHT+IEX3S7oi/KHeM8vE5UDB3mf3Ubtv0N0TphAa3ZFzJW0gx7CAmYdrXLSKC9jB+hZgEHqPRIUzA==
X-Received: by 2002:a05:6214:1c86:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6e243b91093mr102586276d6.3.1738198823555;
        Wed, 29 Jan 2025 17:00:23 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e2547f0e00sm913736d6.24.2025.01.29.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 17:00:22 -0800 (PST)
Date: Wed, 29 Jan 2025 20:00:22 -0500
Message-ID: <c8c74158894e1b955a8b09509b8ce26d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250129_1952/pstg-lib:20250129_1951/pstg-pwork:20250129_1952
From: Paul Moore <paul@paul-moore.com>
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, audit@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v3] audit: Initialize lsmctx to avoid memory allocation  error
References: <20250129120652.308571-1-chenhuacai@loongson.cn>
In-Reply-To: <20250129120652.308571-1-chenhuacai@loongson.cn>

On Jan 29, 2025 Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> When audit is enabled in a kernel build, and there are no LSMs active
> that support LSM labeling, it is possible that local variable lsmctx
> in the AUDIT_SIGNAL_INFO handler in audit_receive_msg() could be used
> before it is properly initialize. Then kmalloc() will try to allocate
> a large amount of memory with the uninitialized length. 
> 
> This patch corrects this problem by initializing the lsmctx to a safe
> value when it is declared, which avoid errors like:
> 
>  WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_pages_noprof
>  pc 900000000304d588 ra 9000000003059644 tp 9000000107774000 sp 9000000107777890
>  a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000000 a3 0000000000000000
>  a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000010 a7 0000000000000000
>  t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c80 t3 000000000000002e
>  t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6310 t7 000000000000002f
>  t8 000000000000003c u0 00000000000000b4 s9 900000010006f880 s0 9000000004a4b000
>  s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673400 s4 9000000107777af0
>  s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff000 s8 0000000000000004
>     ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
>    ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
>   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>   PRMD: 00000004 (PPLV0 +PIE -PWE)
>   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>  ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
>   PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>  CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1+ #1899
>  Stack : ffffffffffffffff 0000000000000000 9000000002debf5c 9000000107774000
>          90000001077774f0 0000000000000000 90000001077774f8 900000000489e480
>          9000000004b380e8 9000000004b380e0 9000000107777380 0000000000000001
>          0000000000000001 9000000004a4b000 1f3f37829c264c80 90000001001a9b40
>          9000000107774000 9000000004b080e8 00000000000003d4 9000000004b080e8
>          9000000004a580e8 000000000000002d 0000000006ebc000 900000010006f880
>          00000000000000b4 0000000000000000 0000000000000004 0000000000001277
>          900000000489e480 90000001066b6300 0000000000000012 fffffffffffff000
>          0000000000000004 900000000489e480 9000000002def6a8 00007ffff2ba4065
>          00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
>          ...
>  Call Trace:
>  [<9000000002def6a8>] show_stack+0x30/0x148
>  [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
>  [<9000000002e0fe18>] __warn+0x80/0x108
>  [<900000000407486c>] report_bug+0x154/0x268
>  [<90000000040ad468>] do_bp+0x2a8/0x320
>  [<9000000002dedda0>] handle_bp+0x120/0x1c0
>  [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
>  [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
>  [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
>  [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
>  [<9000000002f1065c>] audit_receive+0xe4/0x1c0
>  [<9000000003e5abe8>] netlink_unicast+0x340/0x450
>  [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
>  [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
>  [<9000000003da32f0>] __sys_sendto+0x100/0x170
>  [<9000000003da3374>] sys_sendto+0x14/0x28
>  [<90000000040ad574>] do_syscall+0x94/0x138
>  [<9000000002ded318>] handle_syscall+0xb8/0x158
> 
> Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update commit message and CC list.
> V3: Update commit message again (thanks to Paul).
> 
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The backtrace in the commit description still exceeded the width of an 80
character wide terminal :(  I trimmed the problem sections of the
backtrace and merged this into audit/stable-6.14; as soon as I can get a
clean kernel build I'll send this up to Linus.

--
paul-moore.com
