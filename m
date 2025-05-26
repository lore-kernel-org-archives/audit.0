Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1C190057
	for <audit@vger.kernel.org>; Mon, 26 May 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288668; cv=none; b=R7FQib+sfrAMMhtGBCTU2m6VGcBxKyiX6pi6uTpjvGVamBS2764kR+1ANkWmRv9CcTbv5Yg8QdcLw31Q5xw+HmdGs6yUA+dW1a+iroSu4eS3UFOjVhTUXQImsIwQSNIr60aA/lwFKxwCI/gIq5KivW5eCs7zlMF48YQ5oOKii2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288668; c=relaxed/simple;
	bh=CK8JysKVIn1wabbBll5P2AsB0jqzQ5UGq0g3MIz+lOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQvjenjmn5wF+6qK4qTVZw2+lxcOjDBgLs3vEprJDnjEnLdiFETxq6OCHMd48Uh3cZtug8PUW0WRuGyM7KtahfolJ7u3rH8Ezp69Pfz0hKZboDUdiems9eFm2RYsQxwHG+Ut9XziVYJbkf2TskqzA7U7JWLLdnLUOogw+uIVGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IEkOrNr0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IEkOrNr0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476f4e9cf92so16526361cf.3
        for <audit@vger.kernel.org>; Mon, 26 May 2025 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748288665; x=1748893465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6x3GVRBafOUbt6XMXviRAhsrN8EerSjpBJlqi+s3Vo=;
        b=IEkOrNr05vSVGm5xCYwH8+78u+fCdbgo7DEG7nAAeSXD1LgmJYtFHLDxh6rlYyNMQj
         NXTPrW+AopYqY3fGCCcWpDGbVv79A4+oIJH2tKWD0Oy4M+9MDroctPOVvgzhnP94V72P
         3BIT1VGIBaU2QdR5vpHRcCjbHN6kgFN/C0/YgoDsqKKWYRnifdkib1ltMmygVFuRtIoF
         2HUEvmR6Y7MOnr4HwSw0ElmAmpe7y19hsKnPnkoysMW1IlDaQmjOFP6TaPAXq128eWNa
         ndpiZS2z8hJoYRq1mkgRV/Tc1qAiCvQkoRJkdS2hUtLLMx2pGo3aoAzhtsIrubg5cM/R
         bz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748288665; x=1748893465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6x3GVRBafOUbt6XMXviRAhsrN8EerSjpBJlqi+s3Vo=;
        b=CWOVC0lR3AQtG3RWnXKYdDxuf/E5J9xpnueCN8vYszuwKQWcfKldkom+wwYROLCat/
         25UpTpzhojUGuojKYTZl8hLbaeAlsR4pRI6hA8v4Xpjnryh5l5ry04qg7K+yKeQtQaLP
         P5At3lWrEkQ4vWkpp5ib/eiXUfmgH4q9GgHO0v4BWBMMrn6mQVT2s4KpBtm/bp8jkPnZ
         wcUhnjak77iyPMk2U7q2E0Nu1LvMyPm+7+AXnOgRR7YywXfbOYaRfcIDIPvhrzSrgMu4
         dgz8b8S2kjc77tA7KtwexLdgUqTOjD4O9YJXqNp3tKL2fH7D3DEZmlc7828KK0tZJoGa
         uMjw==
X-Forwarded-Encrypted: i=1; AJvYcCWGzqHQ3sSn0Ufko6q1FpOs7lKUGIMBs/TEdq3v59CKxe0VOYrqFqyvLyHg9SlFyDNZBurKAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuz5b09r/vy8bcqr7FujNXF1jgZg2azbV0nNf3Gqd1EO3+w5n
	ISvk8sZ9tOxcLKTilClIePwfF2MhEAIiFXTpEzLRXtGsy4m3jzV2r+Zu/uTSpF+IG9s=
X-Gm-Gg: ASbGncsZ69RBmqFychhPG7logwomW2EWnZTdswJHp/+p9yfUZdC8hE832o+m+Qand/K
	TA2bkS6imZFMjoq6s7CIW4f45WSMor8yP1h+RGJvoo1XrEfE/a+z8012lGGJZmYoFE44T1ZiQFj
	Q/Z/IsOKeoOnCoVXo01pRJ9yUNgmQe867B8Uq+kJfpAP56qKd8P8ft8Tivh2t0vTGhfx/0wkH6o
	c9NQTm6MZVD6Av1myYn0JwWUJsRUfUnmu2W+bSgIwkZVQBgL/WIDZjvE2iBnTM43B9qdRV+h4Pi
	9Gcayj6K51iDclcxOcXxP4UuyMXUYAICIMIr2Eyq+fkBA48Y2ObH62spnCzJVd2YIZcVvFGB5vC
	v2Oae+ZkmkQgUNTZNG8LDsndQTuA=
X-Google-Smtp-Source: AGHT+IFxiSMJYUELeSfxwISguMW9AfotmvIS4kvd05cibYoRecWr7wlxSwNjUohVu4Je0SWxeRs4Pg==
X-Received: by 2002:a05:622a:7e08:b0:489:7daf:c237 with SMTP id d75a77b69052e-49f480c8f2emr118958631cf.45.1748288665412;
        Mon, 26 May 2025 12:44:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3f9244sm156310781cf.29.2025.05.26.12.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 12:44:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJdkG-00000000UXa-1OLX;
	Mon, 26 May 2025 16:44:24 -0300
Date: Mon, 26 May 2025 16:44:24 -0300
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
Message-ID: <20250526194424.GG12328@ziepe.ca>
References: <20250516183516.GA643473@ziepe.ca>
 <20250517171459.15231-1-chath@bu.edu>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250517171459.15231-1-chath@bu.edu>

On Sat, May 17, 2025 at 05:14:59PM +0000, Chathura Rajapaksha wrote:
> On Fri, May 16, 2025 at 2:35 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > By PCI bus error, I was referring to AER-reported uncorrectable errors.
> > > For example:
> > > pcieport 0000:c0:01.1: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
> > > pcieport 0000:c0:01.1:   device [1022:1483] error status/mask=00004000/07a10000
> > > pcieport 0000:c0:01.1:    [14] CmpltTO                (First)
> >
> > That's sure looks like a device bug. You should not ever get time out
> > for a config space read.
> 
> Just to clarify, the above error was triggered by a write to the
> configuration space. In fact, all the errors we have observed so far
> were triggered by writes to unassigned PCI config space regions.

Yuk, devices really shouldn't refuse to respond to writes or reads :(

> So far, we have seen this issue on five PCIe devices across GPU and
> storage classes from two different vendors. 

Ugh, that's awful.

> > Alternatively you could handle this in qemu by sanitizing the config
> > space..
> 
> While it's possible to address this issue for QEMU-KVM guests by
> modifying QEMU, PCIe devices can also be assigned directly to
> user-space applications such as DPDK via VFIO. We thought addressing
> this at the VFIO driver level would help mitigate the issue in a
> broader context beyond virtualized environments.

VFIO can probably already trigger command timeouts if it tries hard
enough, as long as it is a contained AER I don't see that the kernel
*needs* to prevent it.. 

For virtualization I really do expect that any serious user will be
tightly controlling the config space and maybe this finding just
supports that qemu needs to be enhanced to have more configurability
here.

It certainly is easier to add an option to qemu to make it block
any address not in a cap chain than to add a bunch of PCI ID tables
and detection to the kernel..

Jason
