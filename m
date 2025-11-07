Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E626E6F6
	for <audit@vger.kernel.org>; Fri,  7 Nov 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762551516; cv=none; b=cngrLv+S1GE13wZKHdZT/S1PQ0GKTw1pUZOr93TTY1xmcOMhKDdkrQ4tZtrDWBDMCzEm9do/aTvLK5hudhgWKKh+enxJ6w691dqYEmbth5gZLHPHMj/YWjOOuJCOeoP6JCm9twS5m4nXZVyiXbOQ2Sb8pF55vTMp4wT0eCEIrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762551516; c=relaxed/simple;
	bh=eC5w9e5p2UwCo30/na5HREwG6Yejo4STjKDNveCEeYA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=i0x3+tuiwmW5+uzN4WotCWgFbeHnk2Tu1Irpg6r5M2i6bOEry5jEyfiay0f8CVXnseUud5E4GRN8BAOz+XmFU5VsTLmSoOdjQcw8mJSYXH7b51lC9HSrSbZ/r5eUooj44o/8ACbWV75cEFT+bKjxpx5kETSu3zyy2VgY+3JTUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NZGpMq/S; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NZGpMq/S"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-880576ebe38so11118036d6.2
        for <audit@vger.kernel.org>; Fri, 07 Nov 2025 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762551514; x=1763156314; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVIuMvMoyvxEOgTCQ0HI1i8nbI+9PBsxj8orlW9SoCU=;
        b=NZGpMq/SpxJ4LUK7lfcPPvt2NRh4SKRVJCcvFGX6gq8NwNQcpIcGOQuradLEUHfJ1n
         h+k6E7jINAcECv3qxP9sfK3ZJJjXefTcibxyK3NxnNtW/K8KymDfv54FMfwZnOk1ARWj
         mtBUkNaHi44Gus2YJXqtZF8eC0Kt2yHLqJ2uCFeZOkwWMooFhaTcsIRDjJNEhYliHHIm
         YrtxUVMu0Pu7x1Uog7Ov56soT/b0pgRzpHrgeMp9Np/er6CuT9HZLyJQP922gz03dkxe
         D0ns9vZNRom7MmjAEHuuXzF5TySR2buNMgMi/j/vKi8T+JZG34FWtABCYDoZnCqPPsrV
         uKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762551514; x=1763156314;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVIuMvMoyvxEOgTCQ0HI1i8nbI+9PBsxj8orlW9SoCU=;
        b=QPprQTcr1XZi9EZxEaAU8jQexlcLd7V7cGB6ajjfqtfyHx3YCgQKM+TCe59dfNAfR+
         qLWpfaFdcpE1aRgF3ai4dbgX1xXuPEyZPsp++DjJwew2p7YoWz9H4PjnS0DXN9KKWSlg
         gddjWUXpeKtPC9D3Z0gJj8JTElgKJu7S/IroKZy7DjBWK7ra7cS233lTAHxha2sAb5aB
         8QWwkI/VWpKEXr22R+FU7AJQdIs2Mp624pjKO5UH4SpRP5nvoFzptd0NAtm22du40TIV
         2A6Z6EPtfoi0lAWSIl5f6GCGqgI9WNIPLBoVWcQ4ea5ISE2mXH/OMnSkz8ATZU0y3DBD
         PnyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCMfrpWw+TTIF0Z9ph5YeOBrWJs2Ul+ZsOaT8ul5kwkl0elCAoWUEYgUXjVnsXQ1MG3rliyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGUd/goKTaZpba6AzWyMTCSAWLC8EjtcxdVEPYB7YBpxYkdBd
	gAGBwatAbdNglifVrL2H+fU6roKYNdSHYWaOGGL7vPsexoL53pTTemjbezv8yGHxew==
X-Gm-Gg: ASbGnctHZTV26RBxV4Gzs1LZu6hpRN3tQj3BL3MEmD3Xqn2oqxGXw41Gp0zxOggmdFD
	O7eewk8WZd2V3L/n1Gy1Z0m7XXiHd44HctB5kB++xvIbF8rmit8Skf0PNidsKoDjjUQtBtiew/D
	G89A1Gm3E65PaNoYracoS0+QmQdpzc7mRQd0mFp9pbXJR3UaRmBX7y50B5QZfUDJkZ7KZmVKoJB
	OTHm28fPheN6bsjCSeaee0q5IX0wtiX6cWgYuNlhZrCOgzVCUHQEKCC8YyB1xFE2DR6/vFVv8/k
	Xk+OYb2NIqWLQ95gLnOd2RNEerZd1v0vkMGHPi38VTHyj7EAYccfXXwNZn7HGbm15iGBFSs/ySZ
	zoCUO79YXvcbNoUvysHc3Lk9JAEFLWggLQe5qvcN3cGZuPo4TSDV8f8HLNo2tFbAxPPVyslu8Mz
	lSz6N5V/EOQzOGDbFmreEoK/C90dVOTK+i5APffmgmAKk4mQ==
X-Google-Smtp-Source: AGHT+IGag0EXX+Q07CJmKdp/IGb+g3kWynIf+kJK9P4GIV79NIw3vGTfTxST9FXLzISYvbpsAkWlUA==
X-Received: by 2002:a05:6214:1256:b0:880:415d:a9ff with SMTP id 6a1803df08f44-88238690933mr7961156d6.37.1762551513939;
        Fri, 07 Nov 2025 13:38:33 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b4513fsm2865576d6.28.2025.11.07.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:38:33 -0800 (PST)
Date: Fri, 07 Nov 2025 16:38:32 -0500
Message-ID: <f63160406a534e98d00ac0fd44895c01@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251106_1733/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Gongwei Li <13875017792@163.com>, audit@vger.kernel.org
Cc: eparis@redhat.com, Gongwei Li <ligongwei@kylinos.cn>
Subject: Re: [PATCH] audit: Use kzalloc instead of kmalloc/memset
References: <20251105103619.110504-1-13875017792@163.com>
In-Reply-To: <20251105103619.110504-1-13875017792@163.com>

On Nov  5, 2025 Gongwei Li <13875017792@163.com> wrote:
> 
> Replace kmalloc+memset by kzalloc
> for better readability and simplicity.
> 
> This addresses the warning below:
> 
> WARNING: kzalloc should be used for data, instead of kmalloc/memset
> 
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>  kernel/auditfilter.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This change does result in zero'ing out the trailing string buffer,
which isn't done currently, and shouldn't be necessary, but as this bit
of code isn't performance critical, it should be okay.

Merged into audit/dev, thanks.

--
paul-moore.com
