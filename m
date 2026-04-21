Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA337DE84
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805943; cv=pass; b=NPAPUDQ9JTjbBpInjErmdQ0wghpFGjVDtWZjZj/bCsEXWuZk/SYLnyrrxUJNtwACEczF3x2PDSC0X3pl9OkxRi7+ctSWIlx1FVyOnOrmwjZJWeMM8tBnbRaHjT2xW1Ws+LayMlqifcZ6zI7INkZ4naxP4FIGHSIKwjUEVKnCVfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805943; c=relaxed/simple;
	bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJagvdfdb00WqyIOPOyU3FoSu2CtFT5FnsUjfWrHds17HOoq1rQ0XPLIsyA+Vo5WzOloFhDjNicXrAoIsvtLmX7Gga0D2ukM+03lASQq7sfLyz0OkxPPNjSxhobHj524mz9AT8P8RMrSf73RyPWzfKW0HUA7hJBCiwgQ879JyZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkbVLyyw; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkbVLyyw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so11512255e9.0
        for <audit@vger.kernel.org>; Tue, 21 Apr 2026 14:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776805941; cv=none;
        d=google.com; s=arc-20240605;
        b=KverwSdG5q3WdKShauitUj7E+O1ARvxh6lreNrFbsh9e7bSlgCy2vb6fjkXxHfrqJ1
         BYPw1LbGZx2/0nkwBECG10U6TxpT/sXE7Y298Z/hExMelBRJ96A+onuOrIVL+gBSi06s
         SaBei1ttTFPItQlaMDAG//AIyvO0+Kv+s1GiIXKm1Uan0fveHz0/gBOWgoOVZQ41ZSTX
         r3AgEGX8YWPHIg9l6eoC/T+p9g+F2v1Yi3cLA0JzQxNh7sb3Saouwvq3J0EDDY5d+zpf
         HA7myDRv3lmuP9eFYJOfWrTuwu3/OXSGbFE26XjMIoNpRh3NOJP625DRpaTljyxIH8YW
         ZHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        fh=fS9tJ0RFTGoQYOqgkcbdcgfEnCZFDWJr5CCm+EboSao=;
        b=QC4KGtwp5L3LzE6FTHUj6czvS0Jj3ax6KerZauwT4bcqzih+dfBZ4EjrfDb4QxWeNF
         93vBBGVRDdcybceREP6DRNTM+WY3lOd20arSLxqvBMxMkEARoLvuvwItMJupJLkUbs3l
         9d96T3NZwugfEf74f4P1fV9IPaeRpPCEpnJAssBZIvkIQZaAnJZuaoYvNgxhkkRz2pJr
         cZuPhm8EwleW/lYN0T/k3G4BgvPFgSwXzyHNqe4XpPSeIS8jgNRn9mkVis9rC8gz9Olj
         OR1OGwsAzwGOiAj6uIm0NsSNaBwsxfHROIbBeOSb9ZOvmIRiB+y+2Iyu9RchXDaAODHr
         bzcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776805941; x=1777410741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=RkbVLyywW2pe/i4FFjsAP7VdfebLNgXH7ZVzfuva3izAtjGOeyqkEo7o3tgUCwpr99
         Z+mOJ3zxtRqvZ8J5yknE+0x8tDTdBDH63F3lGsQdlKjHnDmR+IKw/jBCPSBS9ULrq8HK
         oDn1MtqO+ko0Ybh70mlMMWMAS6+rHkxF5Ax597BNkgWxUwwSwU54e/moXxQ2Eb0SlYrd
         zShZzFNWG6Fv+EmMiQSE6PshcaKiQrmfRext32vmNrsk5vYc/dBZL1yRtq74tjbhk/Sd
         +TIsYR8sqSoL6m4qRdJ2pPR5cp92OFhCJOFsC9+xBcArqFgaxLw6KUIBpgrvqRCQX77K
         hy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805941; x=1777410741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=jPpMDB5ZdWRLVKuylZTE/Q/Pr7etx1A9eutZMv3XpOsq2snv9hj+RsUA8NS/VuA339
         plrV/N2Iqu17rXLV20wQGGTtedvRVq/hQz/R5Y1o81L9R3RY/y21hZGx2nsPr+S/iy1t
         ca5tJ8CXuehmgNyVlUUSkMcLQDPJla4KhYvFYYAVLxagIPYtMRVMjCy2Jjtd9QGrm3XZ
         FoMFf1TJ/o0gjcxWijYYLSkp/IHWbbz1ugbi5rMmBFj/gUvRo6ICC//2UDy4qWlnC+rE
         JxNK2miPSPE77MQIDKh1tnii7hhXEVp/dwpPvKHw6KP94G+dsqEGv33fbLUEgx8gskPV
         elBg==
X-Forwarded-Encrypted: i=1; AFNElJ/MvUNUqZo4GvQ71v8bKpvpPNbPQJquCYO2EHaKlxZj7RWiBruYNX1xqD6wBfCxtGm1+0V8vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTz4RWvo/aRt+QQ2YrWjJ1Mz0caPwy9oIN6jGsEkqxgVKM7CmX
	NANXpMj+w7acHhcTaztnrxrSTV+I2zg6eUNygupD0PBqlX+1kbuYyPvh4aiZKllUIIWTgt1VOx3
	7EnWJuzFvmF+IOst/URZ+XjyXy30BGyo=
X-Gm-Gg: AeBDievXPmleLhE4jQrQwPgANNdfWn3ofwUdBcNLBEcZX96DBURqaxm3eNdVT51bt3g
	TEnkGlGZdLwUjinnYJdmHBDE/1+KzfhXGcdv1t1g2QHmIG+3MGjYc1uO48bcyv9VyjwjohpRSOx
	GxSlHB+P/fmE18xycyGLwUmxe67VJG3q2c3s+07RpUIIoxFdYb2nhwma7G2jIeSAhKfEecefmlO
	uJhzL3vGGvi1SD94aIflR1xF5ueYQllDynmDZ9SXRjDnjjTP6ZF43Gyd3iAbUiK7AqGm+4c4H4o
	7b8SJJpvlQhODEN1mLlqIgG5yxUinRklJAqGKdOregfjrZqoljcnZ/uN1haWVSbukC6fZ+m0k80
	NFvBFWylmmKq84BTYD2mfv3cZR3F5KN6lqIkF
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id
 5b1f17b1804b1-48a569cadacmr54957095e9.14.1776805940737; Tue, 21 Apr 2026
 14:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3>
In-Reply-To: <aefnIw1Tx_2r5nkS@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 14:12:09 -0700
X-Gm-Features: AQROBzB7FEGFcLIjJDbSZzRa8uWl-Vr2UW5AqVzs9gp0AZcsBB4lKtYQM5rh6eY
Message-ID: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare.c=
om> wrote:
>
> Hi folks,
>
> I was accepted to speak a little bit about this patch series at Linux
> Security Summit this May [1]. I'm going to use this opportunity to
> re-iterate some of the motivation, what can be done today with BPF,
> drawbacks, and wrap up with discussion topics. I'd love to hear feedback
> from audit, BPF, and security folks to work towards a viable solution tha=
t
> addresses shortcomings to allow for better integration with BPF.

I don't think any bpf folks will be there.
Also giving a talk about it doesn't make it acceptable.
It's still Nack.
