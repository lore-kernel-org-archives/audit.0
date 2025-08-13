Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B92868A6
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100110; cv=none; b=XubsG82huWkV5KeuEd7g7wa1kmeTedLAB51sCPtmOqtCpLY/Q06cVUP4DowcBWC8znohTOWea/52PDW3PjwHcrdL3VamCwmzFI50L0squPCgTZ1QaRnRoYVnp4sNbN9BXzy5X1gKfOjD89/Wv+40MP9rR9pbMgifct5AIzsRDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100110; c=relaxed/simple;
	bh=wjHKB6ug6QLTXYCJJQSW/nStYJh10pIv+On24g943d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o59873SUcV9aZ1wm5MjXOPmdQQTjIHY+WfCRmUHJDtcqP+ZUr66tvA9jMRy4RpC+f6diU9eAmo5G9ZfU5OVnpL+jBGQaOV7JFW+XomzCWwlweOhjhd75eZ9JHOQ6osSLCT/aMQtDHZZUjAIvAOLCwBC7pjQMD11ZALBsQUf/wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eXEORKjx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXEORKjx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7892609a5so4290814f8f.1
        for <audit@vger.kernel.org>; Wed, 13 Aug 2025 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100107; x=1755704907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzS+q+xmuvVbEJJlZUoMjXta+/qBsEsWeg786ovz6b4=;
        b=eXEORKjxzjh0rcvUdlHlUDV9tP169uh9U+99libqU8DNeFvsX7o0fjS5kLLC2RguFZ
         szbdVX3rTZ6v7DFgtKuJVVUzkbFz6+9erzlGXh+k33ZKKSQFTjgaFmpErY6z5S6c+B31
         EZJXjDOy/mVw8z7dxHrrNrGr8gpldlUCC1acK7Su8IeIZD+Ot8faK4jI9iiX8zpWlH1g
         m39KJgwogUcrp6czEIGK/0Sd1CIZi2jaXbYVHAF3bAJc8SPtFtQIADw680b4KAA1lEfq
         cFZ+BMPytzoVRh/81qXAaOcN3cmB1Ym11tIMziJqbzZryvInUd85wDHf6d5QosNKj/RZ
         f59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100107; x=1755704907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzS+q+xmuvVbEJJlZUoMjXta+/qBsEsWeg786ovz6b4=;
        b=SQ5EA3WFX+k5nMhKGuoCBJ9EAo0nkxeLjQeLv2NW09Djv+UGHYeUrVmjqhNbmMUYqZ
         VX32Mc5FP3y4nCnqbUsk/eeMVmJ0THXIo5zdq/YG3EHg4DRC7dAYcDexxA/QIMO0/Bp/
         pkcBl1Jd4xEpHycqydh9dE75aIoSMA1bzhvmoOM0TxUKYfFnRwSacMePUsLFrhf4RZkP
         3NcfHV6N3j09V3I8z7Q9/LSqfwXJR1bhfh+9pOKUQgHbBzCNi2JDVjCLTjMQwN0Xyj9c
         551cVE3WFm8kINW9ITa+2ISYBPZqpFkZKNVDax3sGD3b62t+wNZbqqlgse2I8fpHEXKR
         yaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUpTj+QLYtLD4GQQ+tGl1G0TnWJty2Bg4vPDE6rfWsMD4vv/HgthgHYRLOgBeOgql9ZreOWbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynmkBxsCVCfaqVg+d2EoA7+i9OUxAL06UJW5kLiMZzjeOLP1HT
	wTX5k4istUj/eBAFaQT4PRGqUF7ZuWIwa+okwz7Mi/zM3fEegTq8dTZKhEBT+1apHOY=
X-Gm-Gg: ASbGncs7E4AoU1TFwMi/zDvoP52RceoGhfmnIslJiVy1n1a04IPWgcvNyJzPGE1JYsu
	ZwFK2oUKU7n9rRlZUFGz88RU6tBSJRkd4wroN473YyeQG7J1aOwavdP5CQJXjWcYgZEGwATU6dG
	nIkGG8AEvnY5xKQL96gTtpIOOGOA5T2x/aS1WdzL40ptmCNO8HWgSGTIpPhIekcrBZk5hAnT3mI
	B/LVkSTxggzaX4vCgVANH2sp6pq8YUMk8S8ekI1OCBYUOfaUxKtkAHy9FIcHoSbH4X7q1ijVFkj
	KE/Y3HA/YSfB6Ur359B/gsLG3u9QlAh6nWKFWQUHMwDZauR0VxB8ozn5mCQgj9IeFL6GQN8tBha
	CBcHfJlqVWyu1plXB6/VLwa9W0EhcFHpE9g5ezCIFnvo=
X-Google-Smtp-Source: AGHT+IFj8ACft23R4r1/k5qKQgq7CaowimpyYgQ/Zx1sb7i2e+C5jJeIrm0zk9PVrrfu2DCBJTN1cA==
X-Received: by 2002:a05:6000:2502:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3b917e36d09mr3177175f8f.13.1755100106753;
        Wed, 13 Aug 2025 08:48:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1a53a5efsm7447925e9.23.2025.08.13.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:48:26 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:48:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	audit@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] audit: add a missing tab
Message-ID: <aJyzxx07nycUmDde@stanley.mountain>
References: <aJwkwMRSxUAvI4dF@stanley.mountain>
 <9ec4a351-de59-4b6b-b200-3a2fd6cbd9a9@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec4a351-de59-4b6b-b200-3a2fd6cbd9a9@schaufler-ca.com>

On Wed, Aug 13, 2025 at 08:39:33AM -0700, Casey Schaufler wrote:
> On 8/12/2025 10:38 PM, Dan Carpenter wrote:
> > Someone got a bit carried away deleting tabs.  Add it back.
> 
> Of course, it should be the way you want it to be, but I don't
> see the reasoning. Help me understand.
> 

The "call_panic = 1;" has to be indent one tab more than the
if (audit_log_pid_context()) check otherwise static checkers complain
that the if statement isn't indented.

  1771  ________for (aux = context->aux_pids; aux; aux = aux->next) {
  1772  ________        struct audit_aux_data_pids *axs = (void *)aux;
  1773  ________
  1774  ________        for (i = 0; i < axs->pid_count; i++)
  1775  ________        ________if (audit_log_pid_context(context, axs->target_pid[i],
  1776  ________        ________                          axs->target_auid[i],
  1777  ________        ________                          axs->target_uid[i],
  1778  ________        ________                          axs->target_sessionid[i],
  1779  ________        ________                          &axs->target_ref[i],
  1780  ________        ________                          axs->target_comm[i]))
  1781  ________        ________        call_panic = 1;
  1782  ________}

regards,
dan carpenter

