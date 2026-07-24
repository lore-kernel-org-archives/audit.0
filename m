Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492E2E2DFB;
	Fri, 24 Jul 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904820; cv=none; b=dPKsDyaXLEEYNXNBmOq82NvpaQDR63Ye59bOchHyGoKAv0++30Tee61G81JGC5+FlfUsCzd0iHV+t403GfUCKI8udSSmpxxndibGDu2/SmKP2JLdPU6s8sDbbqlpuqHXLwH9DE5MlvOVA4ImIYO6Yp0/ZVU3q9olQISmEmuo+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904820; c=relaxed/simple;
	bh=L+/7y63ogR4FwfUuuNc+XWgeV6zSTZ/73r5e48qP9kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRBsOKOclL1TZiYvrl4JnjMICEaQpbR5fVmdvGUZdD0xC/eWfT4LCzvoF4NbDsW864kkwM8hHUZabVk6Vtpt7YmJAase/YT0iaz1z4xBtuFiY/j72jlpWKx5HXxcS+hkiyWzAQEGZESygX0Kc75QB85AVdp2gfwm1h5GyAEg6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R91iXaI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R91iXaI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287661F000E9;
	Fri, 24 Jul 2026 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904818;
	bh=TuiqrxRDtIBl6/qO5JaWMo3g74y4ZaaFSB9qiqwjhKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=R91iXaI+cd4+S2QPGKFrkXkqXvw+VlzMXZ2fO9T1EKfFbAy0hkQtxKUwTFEwjPwc4
	 Wy+TS2q1CZSIDXSvCw/+jdM7ZhgroEyJB/hHGw5MeskJKjzeh27IqsPI1t73Cl3jnA
	 fgvX0YUUrdSQVZhGVAIgCdZ/YuPl1GtHKliobguZ1mGaAVMBU/uZNhBPOTamDwIl5x
	 bUDVp/B13pdbjX0tm31JYoqNgHspBA9lIr4jv38eHtJaYXFNIoq5SBEBfF/LgAL9VL
	 lZYTR5QpBRDbsuZL1YEQRealK4mZP4iJNTufzKV6UP0NxlhRtfm56wEDqiu4JBh70q
	 7Tcbhz4KWKveg==
From: Thomas Gleixner <tglx@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, eparis@redhat.com,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] audit: Force audit_context() to be always inlined
In-Reply-To: <CAHC9VhSohbG8n5WW4VaEjU7nVA4WCrkJ1eD-=34ioaJOQ0-rCg@mail.gmail.com>
References: <20260721040118.1000554-1-ruanjinjie@huawei.com>
 <87jyqolqn3.ffs@fw13>
 <CAHC9VhSohbG8n5WW4VaEjU7nVA4WCrkJ1eD-=34ioaJOQ0-rCg@mail.gmail.com>
Date: Fri, 24 Jul 2026 16:53:35 +0200
Message-ID: <87mrvgjv68.ffs@fw13>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23 2026 at 13:21, Paul Moore wrote:
> On Tue, Jul 21, 2026 at 3:59=E2=80=AFAM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> On Tue, Jul 21 2026 at 12:01, Jinjie Ruan wrote:
>> > commit 6f25517010dd ("entry: Rework syscall_audit_enter()") relies on
>> > dead code elimination to remove the call to syscall_enter_audit() when
>> > CONFIG_AUDITSYSCALL is disabled. However, with s390 GCC 13.4.0 +
>> > CONFIG_KASAN, audit_context() is not inlined despite being marked
>> > inline, causing an undefined reference to syscall_enter_audit().
>> >
>> > Force audit_context() to be __always_inline to ensure the conditional
>> > can be constant-folded and dead code elimination works correctly.
>> >
>> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > Closes: https://lore.kernel.org/oe-kbuild-all/202607181530.2nx8zb3J-lk=
p@intel.com/
>>
>> Obsolete. Is already in:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3D=
core/entry&id=3D6f25517010ddd3f8080d7e06b9b1cb1b64b73772
>
> It would have been nice to see that patch CC'd to the audit mailing
> list for obvious reasons.
>
> Since I'm just looking at that tip tree patch now (perhaps there are
> other preceding patches that affect this?), does it still compile
> properly when CONFIG_AUDITSYSCALL is not defined?  With
> syscall_trace_enter() calling out to syscall_enter_audit() that is no
> longer inlined in the same header, and no dummy function/macro defined
> for syscall_enter_audit() when !CONFIG_AUDITSYSCALL, it looks like
> there might be an issue on some configurations, no?

It compiles properly due to dead code elimination on everything except on
old s390 compilers for whatever reasons.

I'll bite the bullet and add the stub inline for syscall_enter_audit(),
though keeping audit_context() __always_inline makes a lot of sense as
especially clang has a tendency to out of line the most trivial inlines.

Thanks,

        tglx
