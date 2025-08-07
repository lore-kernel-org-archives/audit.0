Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED611B3937
	for <audit@vger.kernel.org>; Thu,  7 Aug 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531262; cv=none; b=rDk2FzhYOEzlo6pgHhAW+Ud9hc7qcPOUJOV//8EcyslWIn1vTRMA16QLZcu/82MAhaAOwMMoUvjCAjKcquPuwt11XK307uk5JUo+IgcwOyeDTq76oZx1fxHmvDYGTa+8EGzdTVmvaUaOy7gaLcHJHO+xQLpuhYzyHlP6QQTVwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531262; c=relaxed/simple;
	bh=3/ZBMbX1rfnr2/RwjuPJssXYwyCyUeok6+T+rCEfBb8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EVsaCqtmq8PAFkH0rTpHdEDnfroWc4e13Ui2csbsIFQ/THRVPDdKXHjUf/m1696l3QRJe6AUPSY4BKG0FJDct2PfRlxtoC6MGWG7o166y+Uyl3s5P0e/Oi7FSwoS08qGA9udhu0QQ3RgAUIwda2hYPz3A/6GIuOZQ8Qj+eWMRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4k4FZ1w; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4k4FZ1w"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70884da4b55so6149196d6.3
        for <audit@vger.kernel.org>; Wed, 06 Aug 2025 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531259; x=1755136059; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=B4k4FZ1wJZ26kcCyeGSrszGuKAKl02WCI416bWqISmNCYvQ6EK0AwLXxPrtiF/M/fm
         MF1URsmzdzSnjtufA6F0oLPbUx3DFAYc3mjPhq8qHsETHQtpzzA1uBK2jvfcuJAtWARt
         8psGtVUIPqJUEgVFmIQTLPiUStheypEhm4FdE8E+q4ECs5mrE2GFlspXgM/2UyotyEkw
         3h1N5F9N/dg0Plh2auIG28/P1Ux8s+lusU0xAMhRO/YymAXtDmme7kQ++SvAPv6xlKpb
         IUdfapwquOomZ90aZB38VYLfQ1S0aF+VAb/G72wwKKH5UtsJ84+lL+ziZhM77AY8qq3a
         Vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531259; x=1755136059;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=hqQtqF1ismBo1B84YlVw5zs02TgbrRFrcAMejBj1LSxf3GOEYpy84Q8qEhiFwr3zy6
         JPlGaLosvCFyN9WnvxuWDgkpabcSbVO8sMJj6ByksiOrjGeeJjP4olb4BoZQZpHTdUQe
         LB20b4rZWc2rQ+rkS+Q4GGvm8OKoqUcoGymriSBJU2nTDTF4PI107OZlpvNwHW6y91xG
         zVply8xZEG09PQ7WkxmHf3G04/OdhE4dOuVR8jhqMitfSL+rTQeYB3NnV3S43PZwpoDU
         hzz36qoIwiX1WIJx136FRzwq2QRnFvfny5/almca6zhNl7+1HIoXXoizDsL1xeJtpibB
         Y+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl3yEGtwVAwwsbKQG7vPxfv/QkcPiFccQ7cdavw/fsmFWkxDu41Z2RJtSXNO6mX35hsQe4sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydOxUhMJg6ZMRr/coznnGVi6X7UKzAZkYMQL7KR2SpYmOwJBOW
	Q9JN00fNI4luk1Xz00MpQly61zgPo53FBPXAnvmbSJylrzET7AYtDPBgZ+ZDy22WkA==
X-Gm-Gg: ASbGncsWbtwp7Q18m/etG4F8BTGK5k+BJJZd7AODhIZBU+luTTM3XpKPH5hdkWbxA6r
	T1Cz87wjubm3IcMuIhJGeUgO33KHtKDILKDG6QProRVShv44Filp1mv+oH8HG8000ElOpxvJiE4
	/DjJVkMPMcRRMSXOv6HusUnCF4sPsUaMT+v0IIIfQL7AG/uIDdojXgT0nrvBjQp/FyFAeS0BcrU
	bScXDYmFgNiC0mGj5UzhrKvWjAyzA1E/29/go3knpKaIEsYQ+nM63Ey7FCheppgpAlaT9ErCb3I
	XLB893hAa6jCY+fixk3KF9VBk1upWsWx7O8DY8tCQddI060xWfl7xXxXtYIfq+YsOYqQejB8thL
	rQjTTeBONY2DLOPtS8JWOZA1y1D8Iy++wAXwaKGdC7T4rbMUkUrskGz+fwSCUagcQU0/X4BxJmn
	o7fw==
X-Google-Smtp-Source: AGHT+IG8gljUkhxjIhCTlEyvnsU1ykkoPiUWoXdbBKK7biBWjQdmiSFWNhS7Sn1nsxWyxlD0vdtbTg==
X-Received: by 2002:a05:6214:20cf:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-7097b055482mr61183906d6.51.1754531259574;
        Wed, 06 Aug 2025 18:47:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cd69b86sm93679226d6.42.2025.08.06.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:47:38 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:47:38 -0400
Message-ID: <74767dff9834360b2100907df5142ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence of  rules
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
In-Reply-To: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>

On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-9065
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> changelog:
> v2
> - re-add audit_enabled check
> ---
>  include/linux/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev-staging with the plan being to merge it to
audit/dev once the merge window closes.

--
paul-moore.com
