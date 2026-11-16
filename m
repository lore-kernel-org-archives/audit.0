Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867108;
	b=h8AIPAvvg0Mc6M661V4YKLkN0UxVB/bllilP2f/1guL5Vbzh38sxs3fQwVMKS7zEdPZS
	 H20uoR7vQlAYi+2pdDaG+r0KnZcxRxoLCAUEn7/dcXjNnpebbHYVHNfwZrwMM4mlvMTWv
	 /PLtfebOmA7LXGJ84YExU5zahL9+4is8AqUHFhG2gv9o1/10AcKAtsayBzwY2gpf6qS4j
	 mWHyxiVt2pjwu2AmpIdWMnjlhP6LQuMgucX62gPWQ/jKaIIWgDq2I+A/+DD3p1mkIUnLd
	 Kc19VTOZ0OCdVLW2+8DfUTugvxqMU+8Nr3TrpLyFVQ+1F4VcKsZVoB65t10/8GuW7Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Subject:References:In-Reply-To;
	bh=zQCKrk04z8HiyEK2+mQt2z6FOfzuq/IEX/OFmVwtW+Q=;
	b=XIGsYoZ65aumvDZj8H2ui/xQJ7b3QzkqTNhxGjc9Cyk/kubsDedbItO8JNnULDEhaj71
	 RH8q7yEpgZo92wVZklt58t30a7iOq7v63cODkVuPUbIeiHapZZqkpdX+ERlozyQvFdX3E
	 Aq1+lItY7vFzwd+lJwSxJCCar6Fs6VHSRgjciedA0ZVNbRwiH1YSQ0P4NFibC5oznO+/x
	 pRg7c5w7mfLvB7JSYStLxupenL2Y+cuzdN7j57xV352sk6kbx4a+h9yqkfBD/NZtPnHAE
	 nkTnldtOdNZiR4B/J980iVrxxdFyq5egP961luDjsEGqNQpS5TyCzwtDpNqgMoguRWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TM5Ybia6;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA1606A31C
	for <audit@vger.kernel.org>; Mon, 16 Nov 2026 22:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFA1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TM5Ybia6
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso62705106d6.0
        for <audit@vger.kernel.org>; Mon, 16 Nov 2026 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794867107; x=1795471907; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQCKrk04z8HiyEK2+mQt2z6FOfzuq/IEX/OFmVwtW+Q=;
        b=TM5Ybia6zRZquZ8IZzrluUlOtRyaz5L+HymrxirXRV0j+GWALzaGE79eSOzQ6yvIVy
         9iwaheVFpnTKYpuGoife7qlBj37dBwDWgfHZWNPIK/YhKtAs60j+qRzB7tRRvjA98x3A
         7URI4/4+6dZI1TRfc5uYQvg5ekClB8d5p+iy20n8Z0xXyf6rE6ygDAdmggESG1EWXtL0
         WPyavOllXF+UNKwayDi3FEB2TlLtJBV90sW0bFr9vXsSrLaPkqjC7zBI4ozAh3H0+pGl
         jb/qoWUxvyjXPArlTOq9rhEAhatqgW8x5+kGiS8hE1LwpBa/85vK6XvqZdHcajE4zLE1
         DxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867107; x=1795471907;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQCKrk04z8HiyEK2+mQt2z6FOfzuq/IEX/OFmVwtW+Q=;
        b=injKMdL85OQfuaCC4N6YxepnFhbrlxW3vWIxYv2HtCCBwtmgXUtG1hTzUaE3IeXVx2
         mwwpvyDi2uM1a+RijjV3FvJfXCj3duPXiX3V99SdvjyJVcHlK7jLVFA0msfYWfOlS3ZI
         IsYTNu0f9ng0altsqQURSm3rojez7oKRFXpBcjbT7Dh/6zhX4yLIrJW0rxWlRbkqmvDv
         CZcKrXvSHYJFg/MmieoFfCV1Vs3LHEvmD1e58dpVkib5f+mh+fdifwR/n6T42TF5c+Kx
         xwPFjS9kplwhYmHVTUfqYEwRzPoUL6Ou3lDDQDq+/G8xK9VoDY5D0RMfQXpXRJfo3U6t
         gQjQ==
X-Forwarded-Encrypted: i=1; AL+hErGx2WqaIWUvOCN3P2XddaSBD63BAhzg8izzreXNFmgDwxFtqUVsKWTbm1lcNgNScYzh03BC5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/G8TVre2HkScTikCl+ft7dDh5WAE6s4cFtyYelsl3Qi4GIyvMI
	9gzl9U5Op/WjjNCYXJddsfdqXMj1SwrOSIsTlHkFDH05SoPeJMgVwlLrA/66qfmH0kA4MPCM7iM
	TysE=
X-Gm-Gg: AZFdTZdHXKTxc7bmM0qeo0VrmXQIGX0zS3zMqqm0DEXXVPvcOzJ2gtb1GPA1NU9XVHZ
	huUXcHmYihsQFKe3knb/eFWp+Zna8gAvBo7HV7k2Fb16+Ulbz/mtMgAtEdF3l2WszLblBybgod9
	G+P3Uwg7WwiMsHhhdKLZv3OdW7cyM73ayfDIIXZJSLkDZmd86VQv8KpmQXuYr3rolPdfsBzl3vp
	GXKlN3AkYeSyY+1CTD1BTxVFeRwAkahE4A/VHrh2LJNln6ZjeUY0GG2BqAiFhuDp9TWVCp0MSmc
	7oOdHLl79wzkORToBq1JS5XYxVhJN3dqhlZwBcFl/IUG8YQf9Qm4Jhh9FhCGpo7l9ifckRguNvW
	/9LzxYN6PpBEUjF2ZdA2CfNK1Xa+6c0lUnuKxcAl27DsG80IMeFaaftijMju7U1qfBAS+RtDiwH
	T+ZNQuHBMSm+neF4OW+6nGoDuML6O8cGoyVWIyWPr89AjVnFU5BmyW49ZgMUPoCgIACGYoN4shM
	1EEjze0JFMvqrtCc2/+OY5ofgWBO+zMYaTbAbx7/f7G7dMo2jgd04rn5hNCuP4zxrCeyKW57uI2
	57nl+AYw7G9wFtzDIkKurtXymsBoSTrUByYsSa6i4aV8VPsNZ2b/OW3C1feQQ7wcnVJRA/goo4N
	aDLNj/r89zVkguTEp21+qhIHK9T1tkQ==
X-Received: by 2002:ad4:5744:0:b0:91f:1525:71aa with SMTP id 6a1803df08f44-91f2412be16mr202121736d6.19.1794867106920;
        Mon, 16 Nov 2026 14:11:46 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d456b2sm96757216d6.12.2026.11.16.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:11:45 -0800 (PST)
Date: Mon, 16 Nov 2026 17:11:44 -0500
Message-ID: <2f79b24aed5483ed9a16953c4efedc02@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261116_1350/pstg-lib:20261116_1227/pstg-pwork:20261116_1350
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2] audit: add missing syscalls to signal class
References: <20261111152057.59798-2-jeff@bencteux.fr>
In-Reply-To: <20261111152057.59798-2-jeff@bencteux.fr>

On Nov 11, 2026 sashiko-bot@kernel.org wrote:
> 
> The pidfd_send_signal(), rt_sigqueueinfo() and rt_tgsigqueueinfo()
> system calls are missing from the AUDIT_CLASS_SIGNAL* class. It seems
> to be used only in kernel/auditfilter.c to increment the audit_signals
> counter.
> 
> This counter is used to determine if information related to a target
> process of a syscall audit rule using signals, such as its pid,
> should be logged (e54dc2431d740a79a6bd013babade99d71b1714f).
> 
> Information related to signals sent via these system calls are
> currently not correctly logged. The current patch adds it to the
> AUDIT_CLASS_SIGNAL* class.
> 
> Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> Changes in v2:
> - Removal of unneeded #ifdef guards
> 
>  include/asm-generic/audit_signal.h | 3 +++
>  1 file changed, 3 insertions(+)

Merged into audit/dev, thanks!

--
paul-moore.com
