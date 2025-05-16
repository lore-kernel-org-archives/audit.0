Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81561C07C4
	for <audit@vger.kernel.org>; Fri, 16 May 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420520; cv=none; b=UU5KeIF8PCuugFR0p0PyzeXWKvRqTxBprqCbTnzbKzN/IwDcHGUFvS0h0zIs3QoB0m3+Vm0hwvu00vT1YqxI4VpE0Yw5vAuYV1kwsD6GGEG9fzxFI8pfzxWi9h02ydyC7Ibmytix00dMx2ia6WY63hUF4qX55T+/apdWa3qit1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420520; c=relaxed/simple;
	bh=/NlBqMOy3OEkgCo+YWYlCYiH+NIpaT+BAv6J6HbLuGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH00yLb//8aD+HRrWUpmwrYhtZTuOaekdPf7Hq/ckIhVDpQeUIEE1ob5kBLIm4FNcB2QbYv+/f4ehbWQLyNLlWVF0/GDC3qWC+yqtvA6dvnfC2eRT+oc2vNPxiCnFvW/zyCBX2T3OqXa4V4yZsxU4dFTyJzAt9jxipQQM4lo09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PsIeL1TE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PsIeL1TE"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47691d82bfbso42295051cf.0
        for <audit@vger.kernel.org>; Fri, 16 May 2025 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1747420517; x=1748025317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BXn+vfm77+VTgYfWSD052O3sih3pqOBHF3asuJA1BI=;
        b=PsIeL1TEcrC89ToAXFivYCsA6aRbflHAzB0Z4H7A5iGBAQLSNWm3iBdktnmZ4Qwegn
         /RkqGiHR94Gg3WwgpaXjHcrbd0gGsVw4efyCzU03ezZxiPTEqk2ExyvX3wJonMpGsayf
         8cZynTkRnNNqGh8TLi2MhLDuhDgs5enJ/WkjWab1OCCT/3cSckCqfpGLr3PG8HDOxESY
         zSErgRo2WRc9g6s4osmO2VQylzKC8tGWUAgl7Xar+nA0Fp1lElPkFhhOVsBTovBNbsy4
         eI5jtu09d7ZqMVYRO0UNwCZyvphf3qsAYv5uvCMr+8MhdpQFU0cGCHksk/i4gLdw1DHz
         +HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420517; x=1748025317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BXn+vfm77+VTgYfWSD052O3sih3pqOBHF3asuJA1BI=;
        b=m5WUIRKdug/0Y4Y9vYUMF6Tc54v51W+LDOGyrnFd4DE0DbFzIBZQ9oLKQxhqn8BUyz
         AaMvaSXJQ9AfHMvsNIkOr9S6vaxeORutX6UVREfZG5di4irMFm5mcTlb6+iAAlnG7ysC
         54dG/pyxFg4eQVojDD4jts5MgAtOHZxLzLQLYfpiqE1toCQpaj9AFhomIXGPtY/EAPM1
         4p//di0o46QI043cM04xnFJsG3nsdkfCOENSsfh8wDsbjVF5ZoCqAJoHJojgynvy+RQP
         0ta5qhj8F+LugCu90h9Px+L7Dn1EkwZWG9i/LinhEi0Dz7++GVw1yqBLiLTgEurf3/d2
         BK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkKxuqIHhVfhu9FP3YemyQB6wPOYhwTqjJF5IUx26oOR5AQvMONvkndtrifYv5JYGpnerqqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFuOGFy8aUEKAyQdQEF1Hp8J17m4MQXUsG35Vbw32zp5rW+aw
	TymlW/tmz8H+XLrgX5IMkG/9JUF3gwpps8tmiKo8OeEsWuSeetVlLZoyrKaUBTE0LN0=
X-Gm-Gg: ASbGncvhGc0sIqwcRLoZ+UA1ErVRRnWB1F2IBDBaZRooPvMWr8t4GNrNxhmLR2r0frO
	gE5NT8b/3PICLZqZpTEPA6SWWttGqpQbOb0xCK1c7rw0RvnUq075InebFn9ZTdAjF2Z1oo409Z5
	ZcPg7AI4sDr2h/18roXZmc6bxCNgyxvskKr/O60Yhex9QXGd1gNx8mJaj3fr2Vsy4joF8U4ityB
	4DD5hCbVy2Ad24CMydrcCjhWyrPkOejcHIR91r91agygyVvkX9pl+3TMZLdjw2FAnXZNB/5Uriv
	oY46LDkIRnLTXhxc9MhFOldEwKCQZUfedSjL1YUyjoVCnbTzqeWtwH+2pgdFt+BzkqLYra0YZrL
	TpkTMp7dAysR/MKZCRB+Tp14MmMA=
X-Google-Smtp-Source: AGHT+IGpq5KJYj/l1wOATwpZyhjeFxOQMatSSzVckaT9OfEIElh7VK70Bh6VZHAPSqyTk3x1rBi/hQ==
X-Received: by 2002:a05:622a:2292:b0:494:7837:90d0 with SMTP id d75a77b69052e-494b098b2ccmr52651911cf.51.1747420517420;
        Fri, 16 May 2025 11:35:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467ef2fbsm149338685a.59.2025.05.16.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:35:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uFzts-00000002iAn-15rd;
	Fri, 16 May 2025 15:35:16 -0300
Date: Fri, 16 May 2025 15:35:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Cc: Yunxiang.Li@amd.com, alex.williamson@redhat.com, audit@vger.kernel.org,
	avihaih@nvidia.com, bhelgaas@google.com, chath@bu.edu,
	eparis@redhat.com, giovanni.cabiddu@intel.com, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, schnelle@linux.ibm.com, xin.zeng@intel.com,
	yahui.cao@intel.com, zhangdongdong@eswincomputing.com
Subject: Re: [RFC PATCH 0/2] vfio/pci: Block and audit accesses to unassigned
 config regions
Message-ID: <20250516183516.GA643473@ziepe.ca>
References: <20250429134408.GC2260621@ziepe.ca>
 <20250516181754.7283-1-chath@bu.edu>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516181754.7283-1-chath@bu.edu>

On Fri, May 16, 2025 at 06:17:54PM +0000, Chathura Rajapaksha wrote:
> Hi Jason and Alex,
> 
> Thank you for the comments, and apologies for the delayed response.
> 
> On Mon, Apr 28, 2025 at 9:24 AM
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > Some PCIe devices trigger PCI bus errors when accesses are made to
> > > unassigned regions within their PCI configuration space. On certain
> > > platforms, this can lead to host system hangs or reboots.
> >
> > Do you have an example of this? What do you mean by bus error?
> 
> By PCI bus error, I was referring to AER-reported uncorrectable errors.
> For example:
> pcieport 0000:c0:01.1: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:c0:01.1:   device [1022:1483] error status/mask=00004000/07a10000
> pcieport 0000:c0:01.1:    [14] CmpltTO                (First)

That's sure looks like a device bug. You should not ever get time out
for a config space read.

> In another case, with a different device on a separate system, we
> observed an uncorrectable machine check exception:
> mce: [Hardware Error]: CPU 10: Machine Check Exception: 5 Bank 6: fb80000000000e0b

FW turning AER into a MCE is not suitable to use as a virtualization
host, IMHO. It is not possible to contain PCIe errors when they are
turned into MCE.

> Is it feasible to support such use cases using a quirk-based mechanism?
> For example, could we implement a quirk table that’s updateable via
> sysfs, as you suggested?

Dynamically updateable might be overkill, I think you have one
defective device. Have you talked to the supplier to see if it can be
corrected?

I think Alex is right to worry, if the device got this wrong, what
other mistakes have been made? Supporting virtualization is more than
just making a PCI device and using VFIO. You need to robustly design
HW to have full containment as well, including managing errors.

Alternatively you could handle this in qemu by sanitizing the config
space..

Jason
