Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB0368D58
	for <audit@vger.kernel.org>; Tue, 12 May 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616342; cv=none; b=K/0uWM85X+9h4RXy/7PyML9a61gSqedD2u6j1rqLcgZ1e+OercYdIZxLComYyhaY09egsex8y74q8uI04b9uJOBx7zvT3cwolhhw5G7yM/jXgMmxg7ZePluqSxE3DZu7KncnXaAlEeV3Kz/xksxwygc3VzksdhktxfvPFWZcPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616342; c=relaxed/simple;
	bh=x21MTF9Y4cEIrS6RrZtFXGQtdcy/uAij1wPTEZTm0Gg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TgmMZI9tTMDvzRnO1LzI40u4pjCADOZ37dwn5my/0zviEVKNR4qsbnC7Grwyt9xFo79CRXxEL8xCnw1pl97rtAvIBt/noQTqZtwQkWIJX7BAMQqlfWRpB0LGYIb2VodZ3KXmLyZHLqrySZ3m+VdCw51d4pfJHxxyJdW4HWrC7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Zy6hwb7U; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Zy6hwb7U"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so768994685a.0
        for <audit@vger.kernel.org>; Tue, 12 May 2026 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778616340; x=1779221140; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OPcweLHpHv1ww1JrOpKTjFRPEE/hvU/xx4wF8rBQS0=;
        b=Zy6hwb7UXVLEeDkxuYtynzw5v55m58fR4PtHL6jRvIwzJ4/3YvjjSGN1LOF3D/6fLi
         qhCsAoSAa2KtGE/sU6w8CwF1R5oMmaurJp5KbuKrmFDVe3/2zXuEe18eOZoAWWxpu/bt
         ePRt7afffTAVUNu0jm3KymtLgIxpq5mRcXDDRxD/UnK1KigJJHIaV51sbupZHe39zfIg
         Ow/QWxR+muYUmouv7Kt3vDtBrInvRdQpS4A5sadcweEc4hp0JEl1eDYZh80vj1nx7HSu
         DNpUXlxzyeAVs2X+i0X8Iwe38GN9tU2FI95dvNWt4ATtKO7Nnl68423xWupOkRmMnDDD
         ZrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616340; x=1779221140;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OPcweLHpHv1ww1JrOpKTjFRPEE/hvU/xx4wF8rBQS0=;
        b=XBSOk/x8/ssTub4KUcFLma7J/aXujo0KoCdIcCJpNgt1F7afTr64/o4XW/11cbFsEm
         N8KHR/J19/LvpAp/+zW1xcRjVyn6Jm+Wk0jETMM1xSpNz9q3Pl751bXUj6NGsQNbsX0D
         9yhM/c+DYaCfTh7qlOFSryHxfgRgZACN9glA41VYorV45FXMw9VF5enIzDXL7fVlZkJT
         aTvXTyAQjHBp+uBnwcKk7rNhi6XW9RvLQo6wBDyY7Iz5OZvW+FV0eIgAPgS2Hroc0jBP
         5aZqrKuBYfK/0WTUPS8nfpCpurykZ1pcJuoQOo/Y+ZDqr1FQjnQHLGn68T68oadmduXB
         35Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8LoTWgfzoWrZ7ptf9AtqB5tTpnGyQxxXGF9HIMR1Wde6ll+DlkSaz0gXjSWOUTAtGU++fd3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2NKGgR8K/4sS2dZ4NEGYCsyEeG3vBnZ9lBDx4TvduQx8/PgR
	m3YDSqIMSYbIfHu7sfkjwJOxjBMyF1+Mpi/oxdZaLh8Jm9QUkKLrMNfEXfJdT9XmEw==
X-Gm-Gg: Acq92OFS/Ego21epkYjdV5qgRIeYsAzKxdf2kZCZiVUnz9BUGjCoPGelFBKMVNefx6o
	hLoQl6OFFqRhOwxK6m/BToeCNmi7BgXd3oU1DbW9ZxXkfKCZtkSJodorqOyNhARqQ07fq0Tm+xa
	FNOw56VWedDRA2FK8PrL0z157EZY7F8qpMJYr2rwElVwhplkt3hxWrXFc9N7AAezWWpYahkVngG
	uChwlYc3Ts8M74Kb+ykXQX9YKDqMfrDewavL0CRLW//IoRfpvM2dwkpC8h34/bv8R9sZtE/rFyN
	yz2SRbznVbx2U1sW/8NNoaLyw72HhGOv1dNqbl35UO16Q46UEnIjWc64wOQeD2nleXWY3Av05bH
	kqiFVVPH/0OaEIC5IPCkA7Z2wUXh4294TZOJtH1nGlk0zuL0I4MXScdUvsASDSHiY/hqGmRBATZ
	vDHqIroJFdkKnQKHto52FsvziXisSCxnpTDHDDvPqEjVz1/HJGAENGv3uv8IxLNOok209k
X-Received: by 2002:a05:620a:e14:b0:8ee:91d6:cd2c with SMTP id af79cd13be357-90cb9b07908mr516560485a.42.1778616339633;
        Tue, 12 May 2026 13:05:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90f666b5467sm60726185a.46.2026.05.12.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:05:39 -0700 (PDT)
Date: Tue, 12 May 2026 16:05:38 -0400
Message-ID: <ca2feee94cf63464559bcf75c113c242@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260512_1209/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Sergio Correia <scorreia@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, sergeh@kernel.org, jmorris@namei.org, rrobaina@redhat.com, Sergio Correia <scorreia@redhat.com>
Subject: Re: [PATCH] audit: fix incorrect inheritable capability in CAPSET  records
References: <20260512132833.1304542-1-scorreia@redhat.com>
In-Reply-To: <20260512132833.1304542-1-scorreia@redhat.com>

On May 12, 2026 Sergio Correia <scorreia@redhat.com> wrote:
> 
> __audit_log_capset() records the effective capability set into the
> inheritable field due to a copy-paste error. Every CAPSET audit
> record therefore reports cap_pi (process inheritable) with the value
> of cap_effective instead of cap_inheritable.
> 
> This silently corrupts audit data used for compliance and forensic
> analysis: an attacker who modifies inheritable capabilities to
> prepare for a privilege-escalating exec would have the change masked
> in the audit trail.
> 
> The bug has been present since the original introduction of CAPSET
> audit records in 2008.
> 
> Fixes: e68b75a027bb ("When the capset syscall is used it is not possible for audit to record the actual capbilities being added/removed.  This patch adds a new record type which emits the target pid and the eff, inh, and perm cap sets.")
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sergio Correia <scorreia@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good work, thanks!  I'm merging this into audit/stable-7.1 and will
send this up to Linus later this week.

--
paul-moore.com
