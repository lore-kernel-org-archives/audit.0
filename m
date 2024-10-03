Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEF1AAE2E
	for <audit@vger.kernel.org>; Thu,  3 Oct 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982309; cv=none; b=jzQR1krQXTDxQ+i6tC8qutIQtGO/nJD3GzaO8qv7IrvktKrC4D9lbmcwKaxdgUUPbzJL9lOkjsPa8jzNHsav0eDkb6CdfmAESXjJ+G5jcOKLS9DCg7f7FBTW/UZTZCWYox5ninZBkq6Jl4O6iUYE40YxZvy78Ws7KAE7UzaMmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982309; c=relaxed/simple;
	bh=EO+rIjcalLl0UyJNGyeHDPs7fr3LWWjOTDvBjTZ6VmA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=RagljNB+yLvdATOgF48kh8l3VDyIhKB0IBsm37gI2Xg/6zpYmfDqyWQA3z++iRU74iQ/DmVrOwVIW6V56zitJx5qpZB1uFkAx9o/asi4baHQ2YZ5bhfxZ4sydlD28TsoyyhusuSgCTcQL661sIujCZxNWw8Xpk04ZBGGtfEqUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=byhOD6BS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="byhOD6BS"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2a6d3144so7110196d6.2
        for <audit@vger.kernel.org>; Thu, 03 Oct 2024 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727982305; x=1728587105; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNRIa5qIumwRTfSXXFOYZoo7ymeiWvLSvGCidwOvYqk=;
        b=byhOD6BSWIYKotdnG9dzQQjaSGTFCvTWBsRaNhi7phsyQMV3W9PNWicL7GnxoO5K5M
         xH3lZLWNQ1E3uj+fTxWDRE/lkHajUfzSH0fkW7nBNqqYxc+qJERQWMVKTF4DFszALMer
         nZLeVTmvqGdMkhlGJsaltzNcK7f7jFTW+9NFTr2hQMkGqZJBmFTxgCWEvdV08xWNZuHV
         jDVYp6OuVHD7d7Q+Ciq/tMgYDVDxfLYrpERfci0y3CclqzxGfLa9K3T3JkezyLVzUZ0N
         DyWW/HS1kkPPckW/iuyos1dxdqtJE6wwIfBJiA7ozoFWH6+dqcObaAcwBJqjnOCsw3c+
         6iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982305; x=1728587105;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNRIa5qIumwRTfSXXFOYZoo7ymeiWvLSvGCidwOvYqk=;
        b=Ze8Ew6KHK+hd21Fn+dpMDSrhLNHV3G+K2Sk9I8n7alpjVKUJcc2CmxpmZIgPceL5Ab
         8cy6BF4mAh65YFGWmDRa0htjMA5J+oCI10/Ph0V3NFrqoGT4C1yYEeVR99KzoqebNPlN
         DQjqdGNquFDuPC6B6vmTUWV8ROTwK/uXL3uJ1hNgT58v+FfJ4IC2/iiv5jdtQqIXuHW2
         l+arzbnYlf7srA8qRP0+hQe+9/4RXZcYeYSXI8cdMp8JtXfA+b8mDLpEO1aWPJ7mSz3h
         H7GaEgHBmm+yu57Tw0OrR33iD4oaPoQMWdhFnwpwMny1woSL8qPxKqOOOJZStvntkYaI
         aIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXngQOpj/5EaT86l0UOAPtU6FTKCrrR9qoK662S211xB4pmu4J85NtNRDtLvOlUvX1wkUWkVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXr/fG1O8yYY9vJg/XwRKjY8KI8IToXN8m5eeO+xiG35bweQi+
	9YRPzbaRnVWcWT4WXA482KOyV+zkqc0dOlWDDbezE7RSeZDjODx6d3c74jppWg==
X-Google-Smtp-Source: AGHT+IFzFHEp/Cg5sr3Fgw564Vn4ou1XPmoHYQrbBvRJ/CwfeDDtO5uGb/2zpXT0h3NsLfYWRQ7tqQ==
X-Received: by 2002:a05:6214:5784:b0:6cb:52da:dc36 with SMTP id 6a1803df08f44-6cb9a33091amr4294426d6.5.1727982305244;
        Thu, 03 Oct 2024 12:05:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937d3529sm8981266d6.97.2024.10.03.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:04:16 -0700 (PDT)
Date: Thu, 03 Oct 2024 15:03:43 -0400
Message-ID: <581df7c35ca26a432179e705301bf084@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/35] audit: Reorganize kerneldoc parameter names
References: <20240930112121.95324-31-Julia.Lawall@inria.fr>
In-Reply-To: <20240930112121.95324-31-Julia.Lawall@inria.fr>

On Sep 30, 2024 Julia Lawall <Julia.Lawall@inria.fr> wrote:
> 
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  kernel/audit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks.

--
paul-moore.com
